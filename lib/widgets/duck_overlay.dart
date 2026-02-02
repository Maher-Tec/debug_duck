import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../core/duck_messages.dart';
import '../core/duck_config.dart';
import 'duck_bubble.dart';

class DuckOverlay extends StatefulWidget {
  final DebugDuckConfig config;

  const DuckOverlay({super.key, required this.config});

  @override
  State<DuckOverlay> createState() => _DuckOverlayState();
}

class _DuckOverlayState extends State<DuckOverlay> {
  Offset _position = const Offset(20, 100);
  bool _showBubble = false;
  String _currentMessage = "";
  bool _isJanky = false;
  Timer? _jankResetTimer;
  StreamSubscription? _accelerometerSubscription;
  DateTime _lastShakeTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.config.enablePerformanceMonitor) {
      SchedulerBinding.instance.addTimingsCallback(_onReportTimings);
    }
    if (widget.config.enableShakeToRoast) {
      _accelerometerSubscription = accelerometerEventStream().listen((event) {
        final now = DateTime.now();
        if (now.difference(_lastShakeTime).inSeconds < 2) return;

        if (event.x.abs() > 20 || event.y.abs() > 20 || event.z.abs() > 20) {
          _lastShakeTime = now;
          _roast();
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.config.enablePerformanceMonitor) {
      SchedulerBinding.instance.removeTimingsCallback(_onReportTimings);
    }
    _jankResetTimer?.cancel();
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _onReportTimings(List<FrameTiming> timings) {
    for (final timing in timings) {
      if (timing.totalSpan.inMilliseconds > 17) { // > 16.6ms (60fps)
        if (!_isJanky) {
          setState(() {
            _isJanky = true;
          });
          _jankResetTimer?.cancel();
          _jankResetTimer = Timer(const Duration(seconds: 1), () {
            if (mounted) {
              setState(() {
                _isJanky = false;
              });
            }
          });
        }
        break;
      }
    }
  }

  void _roast() {
    setState(() {
      _currentMessage = DuckMessages.getRandomMessage(widget.config.roastLevel);
      _showBubble = true;
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted && _showBubble) {
          setState(() {
            _showBubble = false;
          });
        }
      });
    });
  }

  void _onTap() {
    setState(() {
      if (_showBubble) {
        _showBubble = false;
      } else {
        _roast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.config.showOverlay) return const SizedBox.shrink();

    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _position += details.delta;
            });
          },
          onTap: _onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_showBubble)
                SizedBox(
                  width: 200,
                  child: DuckBubble(message: _currentMessage),
                ),
              _buildDuck(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDuck() {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          _isJanky ? "🔥" : widget.config.duckIcon,
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

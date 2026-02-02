import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../core/duck_config.dart';
import '../core/duck_logger.dart';
import '../core/duck_messages.dart';
import '../widgets/duck_overlay.dart';

export '../core/duck_config.dart';

/// A professional debugging assistant with zero coding skills and strong opinions.
class DebugDuck extends StatefulWidget {
  final String? message;
  final Widget? child; // If used as a wrapper

  const DebugDuck({
    super.key,
    this.message,
    this.child,
  });

  // --- Static Configuration ---
  static DebugDuckConfig _config = const DebugDuckConfig();

  static void configure(DebugDuckConfig config) {
    if (!kDebugMode) return;
    _config = config;
  }

  // --- Session Logging ---
  
  /// Start a debugging session.
  /// Logs are kept in memory and printed on endSession.
  static void startSession() {
    if (!kDebugMode) return;
    DuckLogger().startSession();
  }

  /// Add a note to the current debugging session.
  static void note(String message) {
    if (!kDebugMode) return;
    DuckLogger().note(message);
  }

  /// End the session and print the summary.
  static void endSession() {
    if (!kDebugMode) return;
    DuckLogger().endSession();
  }

  // --- Explain It Slowly ---

  /// Forces a pause to explain your code out loud.
  static void explain({Duration duration = const Duration(seconds: 60)}) {
    if (!kDebugMode) return;
    print("🦆 ------------------------------------------------");
    print("🦆 SAY IT. OUT LOUD. SLOWLY.");
    print("🦆 You have ${duration.inSeconds} seconds.");
    print("🦆 ------------------------------------------------");
    // We can't easily block execution, but we can log user progress or just start a timer that congratulates them.
    Timer(duration, () {
      print("🦆 Time's up. Did you find the bug?");
    });
  }

  // --- Console Roast (Listen Mode) ---

  static Timer? _roastTimer;

  /// Start the console roast listener.
  /// The duck will occasionally comment on your silence.
  static void listen() {
    if (!kDebugMode) return;
    _roastTimer?.cancel();
    _roastTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!kDebugMode) {
        timer.cancel();
        return;
      }
      final msg = DuckMessages.getRandomMessage(_config.roastLevel);
      print("🦆 $msg");
    });
    print("🦆 I'm listening... (roast level: ${_config.roastLevel.name})");
  }
  
  static void stopListening() {
    _roastTimer?.cancel();
  }

  @override
  State<DebugDuck> createState() => _DebugDuckState();
}

class _DebugDuckState extends State<DebugDuck> {
  @override
  Widget build(BuildContext context) {
    // 1. Release mode check
    if (!kDebugMode) return widget.child ?? const SizedBox.shrink();

    // 2. If configured to show overlay, we return the content wrapped with overlay
    // But since this is a widget in the tree, let's treat it as the "Root" or specific placement.
    // If 'child' is provided, we wrap it.
    
    if (widget.child != null) {
      return Stack(
        textDirection: TextDirection.ltr,
        children: [
          widget.child!,
          if (DebugDuck._config.showOverlay)
            DuckOverlay(config: DebugDuck._config),
        ],
      );
    }

    // If just used as DebugDuck(message: "foo"), show the bubble/duck inline?
    // The user example implies draggable overlay.
    // If they just drop DebugDuck() in a column, it might just render there.
    // Let's make it render the duck overlay behavior but localized if needed, 
    // or if they want the global usage, they should put it at the root.
    
    // For MVP compliance with "Duck Overlay Widget":
    // "A floating, draggable duck".
    
    // We will return the DuckOverlay directly.
    // However, DuckOverlay uses Positioned, so it must be in a Stack.
    // If the user puts this in a Column, Positioned will crash/fail.
    // So we wrap in a Stack if needed, or rely on user to put in Stack?
    // Better: wrap in a SizedBox/Stack to be safe.
    
    return SizedBox(
      width: 100, // arbitrary default size if inline
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
           DuckOverlay(config: DebugDuck._config),
        ],
      ),
    );
  }
}

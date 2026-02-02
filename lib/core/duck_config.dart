/// The roasting level of the duck.
enum DuckRoastLevel {
  polite,
  sarcastic,
  savage,
}

/// Configuration for the Debug Duck.
class DebugDuckConfig {
  /// Whether the duck is enabled.
  final bool enabled;

  /// The level of sarcasm.
  final DuckRoastLevel roastLevel;

  /// Whether to show the overlay widget.
  final bool showOverlay;

  /// Whether to log sessions to console/memory.
  final bool logSessions;

  /// The icon to display (default: "🦆").
  final String duckIcon;

  /// Whether to enable performance monitoring (jank detection).
  final bool enablePerformanceMonitor;

  /// Whether to enable shake-to-roast.
  final bool enableShakeToRoast;

  const DebugDuckConfig({
    this.enabled = true,
    this.roastLevel = DuckRoastLevel.sarcastic,
    this.showOverlay = true,
    this.logSessions = true,
    this.duckIcon = "🦆",
    this.enablePerformanceMonitor = false,
    this.enableShakeToRoast = true,
  });
}

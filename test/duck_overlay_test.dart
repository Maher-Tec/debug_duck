import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:debug_duck/widgets/duck_overlay.dart';
import 'package:debug_duck/core/duck_config.dart';

void main() {
  testWidgets('DuckOverlay renders without Directionality error', (WidgetTester tester) async {
    const config = DebugDuckConfig(showOverlay: true);
    
    // We intentionally do NOT wrap this in a MaterialApp or WidgetApp
    // to simulate the overlay context where Directionality might be missing.
    // However, since DuckOverlay produces a Positioned widget, it needs to be inside a Stack.
    await tester.pumpWidget(
      const Stack(
        children: [
          DuckOverlay(config: config),
        ],
      ),
    );

    expect(find.text('🦆'), findsOneWidget);
    expect(find.byType(DuckOverlay), findsOneWidget);
  });
}

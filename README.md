# 🦆 debug_duck

[![Pub Version](https://img.shields.io/pub/v/debug_duck)](https://pub.dev/packages/debug_duck)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-blue.svg)](https://flutter.dev)

> **A professional debugging assistant with zero coding skills and strong opinions.**

`debug_duck` brings the legendary **Rubber Duck Debugging** methodology to Flutter — with humor, structured logging, and verified utility.

---

## ✨ Why debug_duck?

We've all been there. You stare at the code. The code stares back. You say, "This should work." The console says, "Null check operator used on a null value."

`debug_duck` forces you to slow down, explain your logic, and spot your own silly mistakes before they become permanent residents in your codebase.

**It doesn't fix your code. It makes YOU fix your code.**

---

## 🚀 Key Features

| Feature | Description |
| :--- | :--- |
| **🦆 Duck Overlay** | A draggable, floating duck that critiques your actions in real-time. |
| **📝 Session Logging** | Capture assumptions and verify them with structured session logs. |
| **⏳ Explanation Mode** | Forces a 60-second pause to explain your logic out loud. (It works.) |
| **🔥 Roast Mode** | Configurable sarcasm levels from "Polite" to "Savage". |
| **🛡️ Production Safe** | Zero footprint in release builds. All logic is stripped out. |

---

## � Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  debug_duck: ^0.0.1
```

Or run:

```bash
flutter pub add debug_duck
```

---

## � Usage

### 1. Wrap Your App (Optional Overlay)

To see the floating duck, wrap your main app widget:

```dart
import 'package:debug_duck/debug_duck.dart';

void main() {
  runApp(
    DebugDuck(
      child: MyApp(), // 👈 Wrap it here
    ),
  );
}
```

### 2. Start a Debugging Session

When you're stuck, start a session to track your meaningful thoughts (and despair).

```dart
// Start tracking
DebugDuck.startSession();

// Log your assumptions
DebugDuck.note("User should be logged in here");
DebugDuck.note("API response: ${response.statusCode}");

// End and review
DebugDuck.endSession();
```

### 3. The "Explain It Slowly" Protocol

Stuck on a logic error? Force yourself to stop clicking random things.

```dart
DebugDuck.explain(); 
// Pauses and prompts: "Say it. Out loud. Slowly."
```

---

## ⚙️ Configuration

Customize the duck's personality in your `main()`:

```dart
void main() {
  DebugDuck.configure(DebugDuckConfig(
    enabled: true,         // Master switch
    showOverlay: true,     // Show the floating duck
    roastLevel: DuckRoastLevel.sarcastic, // polite, sarcastic, or savage
    logSessions: true,     // Enable session recording
  ));

  runApp(const MyApp());
}
```

### Roast Levels

- **Polite**: Gentle nudges. "Are you sure?"
- **Sarcastic**: The default experience. "That rebuild was unnecessary."
- **Savage**: Emotional damage. Use at your own risk.

---

## 🛡️ Zero Production Impact

We take performance seriously.

- **Tree Shaking**: All `DebugDuck` methods verify `kDebugMode`.
- **Compiler Optimization**: most calls are optimized away in release builds.
- **No Assets**: No heavy assets are bundled in your final app.

---

## � Contributing

Found a bug? Have a roast to add?

1. Fork the repo.
2. Add your feature (or roast).
3. Submit a PR.

---

## 📄 License

MIT License. Use it, fork it, roast it.

---

<p align="center">
  Built with 💙 and 🦆 by <a href="https://github.com/Maher-Tec">Maher-Tec</a>
</p>

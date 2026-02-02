import 'package:flutter/material.dart';
import 'package:debug_duck/debug_duck.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the entire app with DebugDuck to get the overlay
    return DebugDuck(
      child: MaterialApp(
        title: 'Debug Duck Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Start listening for roasts in console
    DebugDuck.listen();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    // Log assumption
    DebugDuck.note("Incremented counter. New value: $_counter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Duck Demo 🦆'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    DebugDuck.startSession();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Session Started! Check Console.')),
                    );
                  },
                  child: const Text('Start Session'),
                ),
                ElevatedButton(
                  onPressed: () {
                    DebugDuck.note("Button pressed at ${DateTime.now()}");
                  },
                  child: const Text('Log Note'),
                ),
                ElevatedButton(
                  onPressed: () {
                    DebugDuck.endSession();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Session Ended. Summary in Console.')),
                    );
                  },
                  child: const Text('End Session'),
                ),
                ElevatedButton(
                  onPressed: () {
                    DebugDuck.explain(duration: const Duration(seconds: 10));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Start explaining... 10s timer.')),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade100),
                  child: const Text('Explain It Slowly'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Tap the floating duck 🦆 to get roasted.\nCheck debug console for logs.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

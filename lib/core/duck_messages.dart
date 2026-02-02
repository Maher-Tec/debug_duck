import 'dart:math';
import 'duck_config.dart';

class DuckMessages {
  static final _random = Random();

  static const _polite = [
    "Quack. Keep going.",
    "Have you checked the logs?",
    "Maybe take a small break?",
    "Explain it to me one more time.",
    "I'm listening.",
  ];

  static const _sarcastic = [
    "Quack. Are you sure about that?",
    "That variable name is... a choice.",
    "Did you copy-paste that from StackOverflow?",
    "It works on my machine. Oh wait, I'm a duck.",
    "You said 'this should work' 5 minutes ago.",
    "I'm not judging, but the compiler is.",
    "Is this a feature or a bug?",
  ];

  static const _savage = [
    "Quack. Delete it and start over.",
    "My grandmother writes better code. She's a duck.",
    "You call this a widget?",
    "I hope you didn't commit that.",
    "Explain it slowly, I have time. You don't.",
    "404: Competence not found.",
    "Have you considered a career in farming?",
  ];

  static String getRandomMessage(DuckRoastLevel level) {
    List<String> pool;
    switch (level) {
      case DuckRoastLevel.polite:
        pool = _polite;
        break;
      case DuckRoastLevel.sarcastic:
        pool = _sarcastic;
        break;
      case DuckRoastLevel.savage:
        pool = _savage;
        break;
    }
    return pool[_random.nextInt(pool.length)];
  }
}

class DifficultyLevel {
  final String name;
  final int low;
  final int high;

  static const String easy = 'Easy';
  static const String medium = 'Medium';
  static const String hard = 'Hard';
  static const String expert = 'Expert';

  DifficultyLevel(this.name, this.low, this.high);
}

class DifficultyLevels {
  static List<DifficultyLevel> difficultyLevels = [
    DifficultyLevel(DifficultyLevel.easy, 36, 46),
    DifficultyLevel(DifficultyLevel.medium, 32, 35),
    DifficultyLevel(DifficultyLevel.hard, 28, 31),
    DifficultyLevel(DifficultyLevel.expert, 17, 27),
  ];
}
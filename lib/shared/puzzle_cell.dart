import 'dart:convert';

class PuzzleCell {
  List<int> notes = [];
  int starting = 0;
  int current = 0;
  int solution = 0;

  PuzzleCell({required this.starting, required this.current, required this.solution});

  PuzzleCell.fromJson(Map<String, dynamic> json) {
    notes = List<int>.from(json['notes']);
    starting = json['starting'];
    current = json['current'];
    solution = json['solution'];
  }

  Map<String, dynamic> toJson() => {
    'notes': notes,
    'starting': starting,
    'current': current,
    'solution': solution
  };
}
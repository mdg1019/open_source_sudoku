class Location {
  final int row;
  final int col;

  Location(this.row, this.col);

  Location.fromJson(Map<String, dynamic> json)
      : row = json['row'],
        col = json['col'];

  Map<String, dynamic> toJson() => { 'row': row, 'col': col };
}
class Cell {
  String type;
  bool revealed = false;
  bool flagged = false;
  int numMines = 0;

  bool get unrevealedEmpty => type == CellType.Empty && !revealed;
  bool get revealedEmpty => type == CellType.Empty && revealed;
  bool get mine => type == CellType.Mine;
  bool get empty => type == CellType.Empty;

  Cell({this.type = CellType.Empty});
}

class CellType {
  static const Empty = "E";
  static const Mine = "M";
}

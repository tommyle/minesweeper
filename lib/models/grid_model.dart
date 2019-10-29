import 'package:flutter/foundation.dart';
import 'dart:math';

class GridModel {
  List<List<Cell>> cells;

  int get rows => cells.length;
  int get cols => cells.length > 0 ? cells[0].length : 0;
  int get totalCells => rows * cols;

  /*
   * Generates a grid of cells with mines placed randomly throughout the grid
   */
  GridModel({@required int rows, @required int cols, @required int mines}) {
    List<List<String>> data = List<List<String>>.generate(
        rows, (_) => List<String>.generate(cols, (_) => CellType.Empty));

    var rng = new Random();
    var i = 0;

    while (i < mines) {
      int row = rng.nextInt(rows);
      int col = rng.nextInt(cols);
      if (data[row][col] != CellType.Mine) {
        data[row][col] = CellType.Mine;
        i++;
      }
    }

    cells = _decode(data);
  }

  /*
   * Creates a GridModel from a list of strings
   */
  GridModel.decode(List<List<String>> data) {
    cells = _decode(data);
  }

  List<List<Cell>> _decode(List<List<String>> data) {
    List<List<Cell>> newCells = List<List<Cell>>();

    for (int i = 0; i < data.length; i++) {
      List<Cell> row = [];

      for (int j = 0; j < data[i].length; j++) {
        Cell tile = Cell(type: data[i][j]);
        row.add(tile);
      }

      newCells.add(row);
    }

    return newCells;
  }

  /*
   * Encodes the GridModel into a list of strings
   */
  List<List<String>> encode() {
    List<List<String>> data = List<List<String>>();

    for (int i = 0; i < rows; i++) {
      List<String> row = [];

      for (int j = 0; j < cols; j++) {
        if (cells[i][j].revealedEmpty) {
          row.add(cells[i][j].numMines.toString());
        } else {
          row.add(cells[i][j].type);
        }
      }

      data.add(row);
    }

    return data;
  }

  reveal(int i, int j) {
    //TODO: Reveal all the hidden mines!
    if (cells[i][j].type == CellType.Mine) {
      return;
    }

    _revealDfs(i, j);
  }

  _revealDfs(int i, int j) {
    if (i < 0 ||
        i >= rows ||
        j < 0 ||
        j >= cols ||
        !cells[i][j].unrevealedEmpty) {
      return;
    }

    List<List<int>> directions = [
      [-1, -1],
      [0, -1],
      [1, -1],
      [1, 0],
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0]
    ];

    int numMines = 0;

    for (List<int> dir in directions) {
      int row = i + dir[0];
      int col = j + dir[1];

      if (row >= 0 &&
          row < rows &&
          col >= 0 &&
          col < cols &&
          cells[row][col].type == CellType.Mine) {
        numMines += 1;
      }
    }

    cells[i][j].revealed = true;

    if (numMines > 0) {
      cells[i][j].numMines = numMines;
      return;
    }

    for (List<int> dir in directions) {
      _revealDfs(i + dir[0], j + dir[1]);
    }
  }
}

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

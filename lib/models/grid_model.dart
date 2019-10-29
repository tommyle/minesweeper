import 'package:flutter/foundation.dart';
import 'dart:math';

class GridModel {
  List<List<Tile>> _cells;

  int get rows => _cells.length;
  int get cols => _cells.length > 0 ? _cells[0].length : 0;
  int get totalCells => rows * cols;

  /*
   * Generates a grid of cells with bombs placed randomly throughout the grid
   */
  GridModel({@required int rows, @required int cols, @required int bombs}) {
    List<List<String>> data = List<List<String>>.generate(
        rows, (_) => List<String>.generate(cols, (_) => TileType.Empty));

    var rng = new Random();
    for (int i = 0; i < bombs; i++) {
      int row = rng.nextInt(rows);
      int col = rng.nextInt(cols);
      data[row][col] = TileType.Mine;
    }

    _cells = _decode(data);
  }

  /*
   * Creates a GridModel from a list of strings
   */
  GridModel.decode(List<List<String>> data) {
    _cells = _decode(data);
  }

  List<List<Tile>> _decode(List<List<String>> data) {
    List<List<Tile>> newCells = List<List<Tile>>();

    for (int i = 0; i < data.length; i++) {
      List<Tile> row = [];

      for (int j = 0; j < data[i].length; j++) {
        Tile tile = Tile(type: data[i][j]);
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
        if (_cells[i][j].revealedEmpty) {
          row.add(_cells[i][j].numMines.toString());
        } else {
          row.add(_cells[i][j].type);
        }
      }

      data.add(row);
    }

    return data;
  }

  reveal(int i, int j) {
    //TODO: Reveal all the hidden mines!
    if (_cells[i][j].type == TileType.Mine) {
      return;
    }

    _revealDfs(i, j);
  }

  _revealDfs(int i, int j) {
    if (i < 0 ||
        i >= rows ||
        j < 0 ||
        j >= cols ||
        !_cells[i][j].unrevealedEmpty) {
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
          _cells[row][col].type == TileType.Mine) {
        numMines += 1;
      }
    }

    _cells[i][j].revealed = true;

    if (numMines > 0) {
      _cells[i][j].numMines = numMines;
      return;
    }

    for (List<int> dir in directions) {
      _revealDfs(i + dir[0], j + dir[1]);
    }
  }
}

class Tile {
  String type;
  bool revealed = false;
  bool flagged = false;
  int numMines = 0;

  bool get unrevealedEmpty => type == TileType.Empty && !revealed;
  bool get revealedEmpty => type == TileType.Empty && revealed;

  Tile({this.type = TileType.Empty});
}

class TileType {
  static const Empty = "E";
  static const Mine = "M";
}

import 'package:flutter/foundation.dart';
import 'dart:math';

class GridModel {
  List<List<Tile>> _cells;

  int get rows => _cells.length;
  int get cols => _cells.length > 0 ? _cells[0].length : 0;
  int get totalCells => rows * cols;

  GridModel({@required int rows, @required int cols, @required int bombs}) {
    final data = List<List<String>>.generate(rows,
        (_) => List<String>.generate(cols, (_) => TileType.UnrevealedEmpty));

    for (int i = 0; i < bombs; i++) {}

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
        row.add(_cells[i][j].type);
      }

      data.add(row);
    }

    return data;
  }
}

class Tile {
  String type;
  bool flagged = false;
  int numMines = 0;

  Tile({this.type = TileType.UnrevealedEmpty});
}

class TileType {
  static const UnrevealedEmpty = "E";
  static const UnrevealedMine = "M";
  static const RevealedEmpty = "R";
  static const RevealedMine = "X";
}

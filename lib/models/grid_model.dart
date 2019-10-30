import 'package:flutter/foundation.dart';
import 'package:minesweeper/models/cell.dart';
import 'dart:math';

import 'package:minesweeper/modules/game_bloc.dart';

class GridModel {
  List<List<Cell>> cells;
  int mines;
  int flags;
  int numRevealed = 0;
  GameState gameState = GameState.InProgress;

  int get rows => cells.length;
  int get cols => cells.length > 0 ? cells[0].length : 0;
  int get totalCells => rows * cols;

  /*
   * Generates a grid of cells with mines placed randomly throughout the grid
   */
  GridModel({@required int rows, @required int cols, @required this.mines}) {
    List<List<String>> data = List<List<String>>.generate(
        rows, (_) => List<String>.generate(cols, (_) => CellType.Empty));

    flags = mines;

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

  toggleFlag(int i, int j) {
    if (!cells[i][j].revealed) {
      cells[i][j].flagged = !cells[i][j].flagged;

      if (cells[i][j].flagged) {
        flags--;
      } else {
        flags++;
      }
    }
  }

  /*
   * A helper function to start the DFS
   * It checks for the losing condition at the start and winning condition at the end
   */
  reveal(int i, int j) {
    if (_isOutOfBounds(i, j)) {
      return;
    }

    // Check for the losing condition
    if (cells[i][j].mine) {
      gameState = GameState.Lose;
      return;
    }

    _revealSearch(i, j);

    // Check for the winning condition
    if (numRevealed == totalCells - mines) {
      gameState = GameState.Win;
    }
  }

  bool _isOutOfBounds(int i, int j) {
    if (i < 0 || i >= rows || j < 0 || j >= cols) {
      return true;
    }
    return false;
  }

  /*
   * This function performs a DFS for unrevealed empty cells that have not been flagged.
   * When it finds an unrevealed empty cell it will count the number of adjacent bombs
   * and continue the DFS to all 8 neighbours until the boundry conditions are met.
   */
  _revealSearch(int i, int j) {
    if (_isOutOfBounds(i, j)) {
      return;
    }

    if (!cells[i][j].unrevealedEmpty || cells[i][j].flagged) {
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
    numRevealed += 1;

    if (numMines > 0) {
      cells[i][j].numMines = numMines;
      return;
    }

    for (List<int> dir in directions) {
      _revealSearch(i + dir[0], j + dir[1]);
    }
  }
}

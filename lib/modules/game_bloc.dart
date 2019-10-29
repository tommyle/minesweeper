import 'package:flutter/material.dart';
import 'package:minesweeper/models/grid_model.dart';
import 'package:rxdart/subjects.dart';

class GameBloc {
  final int rows;
  final int cols;
  final int bombs;

  final _grid = BehaviorSubject<GridModel>();

  GameBloc({@required this.rows, @required this.cols, @required this.bombs}) {
    _grid.add(GridModel(rows: rows, cols: cols, bombs: bombs));
  }

  // revealTile(int i, int j) {
  //   _reveal(i, j);
  //   _grid.add(_grid.value);
  // }

  // _reveal(int i, int j) {
  //   if (i < 0 ||
  //       i >= rows ||
  //       j < 0 ||
  //       j >= cols ||
  //       _grid.value[i][j].type == TileType.RevealedEmpty) {
  //     return;
  //   }

  //   List<List<int>> directions = [
  //     [-1, -1],
  //     [0, -1],
  //     [1, -1],
  //     [1, 0],
  //     [1, 1],
  //     [0, 1],
  //     [-1, 1],
  //     [-1, 0]
  //   ];

  //   int numMines = 0;

  //   for (List<int> dir in directions) {
  //     int row = i + dir[0];
  //     int col = i + dir[1];

  //     if (row >= 0 &&
  //         row < rows &&
  //         col >= 0 &&
  //         col < cols &&
  //         _grid.value[row][col].type == TileType.UnrevealedMine) {
  //       numMines += 1;
  //     }
  //   }

  //   _grid.value[i][j].type = TileType.RevealedEmpty;

  //   if (numMines > 0) {
  //     _grid.value[i][j].numMines = numMines;
  //   }

  //   for (List<int> dir in directions) {
  //     _reveal(i + dir[0], j + dir[1]);
  //   }
  // }

  // toggleFlag(int i, int j) {
  //   _grid.value[i][j].flagged = !_grid.value[i][j].flagged;
  //   _grid.add(_grid.value);
  // }

  dispose() {
    _grid.close();
  }
}

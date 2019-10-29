import 'package:flutter/material.dart';
import 'package:minesweeper/models/grid_model.dart';
import 'package:rxdart/subjects.dart';

class GameBloc {
  int rows;
  int cols;
  int mines;

  final gridModelController = BehaviorSubject<GridModel>();

  GameBloc({@required this.rows, @required this.cols, @required this.mines}) {
    gridModelController.add(GridModel(rows: rows, cols: cols, mines: mines));
  }

  GameBloc.withGridModel({@required GridModel gridModel}) {
    gridModelController.add(gridModel);
  }

  reveal(int i, int j) {
    gridModelController.value.reveal(i, j);
    gridModelController.add(gridModelController.value);
  }

  dispose() {
    gridModelController.close();
  }
}

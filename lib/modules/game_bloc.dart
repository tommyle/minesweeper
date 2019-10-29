import 'package:flutter/material.dart';
import 'package:minesweeper/models/grid_model.dart';
import 'package:rxdart/subjects.dart';

class GameBloc {
  int rows;
  int cols;
  int bombs;

  final gridModelController = BehaviorSubject<GridModel>();

  GameBloc({@required this.rows, @required this.cols, @required this.bombs}) {
    gridModelController.add(GridModel(rows: rows, cols: cols, bombs: bombs));
  }

  GameBloc.withGridModel({@required GridModel gridModel}) {
    gridModelController.add(gridModel);
  }

  dispose() {
    gridModelController.close();
  }
}

import 'package:flutter/material.dart';
import 'package:minesweeper/models/grid_model.dart';
import 'package:minesweeper/modules/timer/timer_bloc.dart';
import 'package:rxdart/subjects.dart';

enum GameState {
  InProgress,
  Win,
  Lose,
}

class GameBloc {
  final gridModelController = BehaviorSubject<GridModel>();
  final flagCountController = BehaviorSubject<String>();
  final gameStateController = BehaviorSubject<GameState>();

  int get rows => gridModelController.value.cells.length;
  int get cols => gridModelController.value.cells[0].length;

  TimerBloc timerBloc = TimerBloc();

  GameBloc() {
    newGame();
  }

  GameBloc.withGridModel({@required GridModel gridModel}) {
    gridModelController.add(gridModel);
    flagCountController.add(gridModel.flags.toString());
  }

  reset() {
    final gridModel = gridModelController.value;
    newGame(rows: gridModel.rows, cols: gridModel.cols, mines: gridModel.mines);
  }

  newGame({int rows = 9, int cols = 9, int mines = 10}) {
    var gridModel = GridModel(rows: rows, cols: cols, mines: mines);
    gridModelController.add(gridModel);
    flagCountController.add(gridModel.flags.toString());
    gameStateController.add(GameState.InProgress);
    timerBloc.resetTimer();
    timerBloc.startWatch();
  }

  reveal(int i, int j) {
    if (gridModelController.value.gameState != GameState.InProgress) {
      return;
    }

    gridModelController.value.reveal(i, j);
    gridModelController.add(gridModelController.value);
    gameStateController.add(gridModelController.value.gameState);

    if (gridModelController.value.gameState != GameState.InProgress) {
      timerBloc.stopTimer();
    }
  }

  toggleFlag(int i, int j) {
    if (gridModelController.value.gameState != GameState.InProgress) {
      return;
    }

    gridModelController.value.toggleFlag(i, j);
    gridModelController.add(gridModelController.value);
    flagCountController.add(gridModelController.value.flags.toString());
  }

  dispose() {
    gridModelController.close();
    flagCountController.close();
    gameStateController.close();
  }
}

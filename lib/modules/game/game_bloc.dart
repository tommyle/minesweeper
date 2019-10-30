import 'package:flutter/material.dart';
import 'package:minesweeper/models/game_state.dart';
import 'package:minesweeper/view_models/grid_view_model.dart';
import 'package:minesweeper/modules/timer/timer_bloc.dart';
import 'package:rxdart/subjects.dart';

class GameBloc {
  final gridModelController = BehaviorSubject<GridViewModel>();
  final flagCountController = BehaviorSubject<String>();
  final gameStateController = BehaviorSubject<GameState>();

  int get rows => gridModelController.value.cells.length;
  int get cols => gridModelController.value.cells[0].length;

  TimerBloc timerBloc = TimerBloc();

  GameBloc() {
    newGame();
  }

  GameBloc.withGridModel({@required GridViewModel gridModel}) {
    gridModelController.add(gridModel);
    flagCountController.add(gridModel.flags.toString());
  }

  /*
   * Resets the game's state using the previous settings
   */
  reset() {
    final gridModel = gridModelController.value;
    newGame(rows: gridModel.rows, cols: gridModel.cols, mines: gridModel.mines);
  }

  /*
   * Creates a new game. By default an easy level game is created.
   */
  newGame({int rows = 9, int cols = 9, int mines = 10}) {
    var gridModel = GridViewModel(rows: rows, cols: cols, mines: mines);
    gridModelController.add(gridModel);
    flagCountController.add(gridModel.flags.toString());
    gameStateController.add(GameState.InProgress);
    timerBloc.resetTimer();
    timerBloc.startWatch();
  }

  /*
   * Reveal the state of the board after a player makes a move
   */
  reveal(int i, int j) {
    if (!gridModelController.value.isInProgress) {
      return;
    }

    gridModelController.value.reveal(i, j);
    gridModelController.add(gridModelController.value);
    gameStateController.add(gridModelController.value.gameState);

    if (!gridModelController.value.isInProgress) {
      timerBloc.stopTimer();
    }
  }

  /*
   * Add a flag to the grid
   */
  toggleFlag(int i, int j) {
    if (!gridModelController.value.isInProgress) {
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

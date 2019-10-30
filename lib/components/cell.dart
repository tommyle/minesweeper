import 'package:flutter/material.dart';
import 'package:minesweeper/view_models/cell_view_model.dart';
import 'package:minesweeper/modules/game/game_bloc.dart';
import 'package:minesweeper/utilities/colors.dart';
import 'package:minesweeper/utilities/constants.dart';

class Cell extends StatelessWidget {
  final CellViewModel cellViewModel;
  final int row;
  final int col;
  final Function(int, int) onTap;
  final Function(int, int) onLongPress;
  final GameState gameState;
  Color _color;

  // factory CellWidget(
  //     {@required this.cell,
  //     @required this.row,
  //     @required this.col,
  //     @required this.onTap,
  //     @required this.onLongPress}) {

  //   );

  _flag() {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage("assets/images/flag.png"),
        ),
      ),
    );
  }

  _mine() {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage("assets/images/bomb.png"),
        ),
      ),
    );
  }

  Cell(
      {@required this.cellViewModel,
      @required this.row,
      @required this.col,
      @required this.onTap,
      @required this.onLongPress,
      @required this.gameState}) {
    if (this.cellViewModel.revealed) {
      if (this.cellViewModel.numMines > 2) {
        _color = brightSun;
      } else if (this.cellViewModel.numMines == 2) {
        _color = brinkPink;
      } else {
        _color = mayaBlue;
      }
    } else {
      _color = ziggurat;
    }
  }

  //TODO: REFACTOR THIS!!!!!
  //TODO: REFACTOR THIS!!!!!
  _cellText() {
    if (!cellViewModel.revealed && cellViewModel.flagged) {
      return _flag();
    } else if (cellViewModel.revealed && cellViewModel.numMines > 0) {
      return FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            child: Text(
              "${cellViewModel.numMines}",
              style: TextStyle(
                  fontFamily: defaultFont, fontSize: 40, color: Colors.white),
            ),
          ));
    } else if (cellViewModel.mine && gameState == GameState.Lose) {
      return _mine();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap(row, col);
        },
        onLongPress: () {
          onLongPress(row, col);
        },
        child: Container(
          margin: EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              color: _color, borderRadius: BorderRadius.circular(4.0)),
          child: Center(child: _cellText()),
        ));
  }
}

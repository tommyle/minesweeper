import 'package:flutter/material.dart';
import 'package:minesweeper/view_models/cell_view_model.dart';
import 'package:minesweeper/utilities/colors.dart';
import 'package:minesweeper/utilities/constants.dart';

class Cell extends StatelessWidget {
  static const flagImagePath = "assets/images/flag.png";
  static const bombImagePath = "assets/images/bomb.png";

  final CellViewModel cellViewModel;
  final int row;
  final int col;
  final Function(int, int) onTap;
  final Function(int, int) onLongPress;
  final bool didLose;
  final Color _color;

  static Color _setColor({@required bool revealed, @required int numMines}) {
    if (!revealed) {
      return ziggurat;
    }

    if (numMines <= 1) {
      return mayaBlue;
    } else if (numMines == 2) {
      return brinkPink;
    } else {
      return brightSun;
    }
  }

  Cell(
      {@required this.cellViewModel,
      @required this.row,
      @required this.col,
      @required this.onTap,
      @required this.onLongPress,
      @required this.didLose})
      : _color = _setColor(
            revealed: cellViewModel.revealed, numMines: cellViewModel.numMines);

  _body() {
    if (!cellViewModel.revealed && cellViewModel.flagged) {
      return ImageCell(imagePath: flagImagePath);
    } else if (cellViewModel.revealed && cellViewModel.numMines > 0) {
      return NumberCell(text: "${cellViewModel.numMines}");
    } else if (cellViewModel.mine && didLose) {
      return ImageCell(imagePath: bombImagePath);
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
          child: Center(child: _body()),
        ));
  }
}

class ImageCell extends StatelessWidget {
  final String imagePath;

  ImageCell({@required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}

class NumberCell extends StatelessWidget {
  final String text;

  NumberCell({@required this.text});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: defaultFont, fontSize: 40, color: Colors.white),
          ),
        ));
  }
}

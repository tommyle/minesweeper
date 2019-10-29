import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/models/grid_model.dart';
import 'package:minesweeper/utilities/colors.dart';

class Grid extends StatelessWidget {
  final GridModel gridModel;

  final Function(int, int) onTap;
  final Function(int, int) onLongPress;

  Grid({@required this.gridModel, @required this.onTap, @required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: jaggedIce, borderRadius: BorderRadius.circular(12.0)),
        padding: EdgeInsets.all(16),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 10,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          children: List.generate(gridModel.totalCells, (index) {
            final row = index ~/ gridModel.rows;
            final col = index % gridModel.cols;
            // final tile = grid[row][col].type;

            return Unrevealed(
                  row: row,
                  col: col,
                  onTap: onTap,
                  onLongPress: onLongPress,
                );

            // if (tile == "R") {
            //   if (tile.flagged) {
            //     return Flagged(
            //       row: row,
            //       col: col,
            //       onLongPress: onLongPress,
            //     );
            //   } else {
            //     return Unrevealed(
            //       row: row,
            //       col: col,
            //       onTap: onTap,
            //       onLongPress: onLongPress,
            //     );
            //   }
            // } else if (tile.mine) {
            //   return Mine();
            // } else {
            //   return Revealed(tile.numMines);
            // }
          }),
        ));
  }
}

class Revealed extends StatelessWidget {
  final int numMines;

  Revealed(this.numMines);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(4.0)),
      width: 10,
      height: 10,
      child: Center(child: Text("$numMines")),
    );
  }
}

class Unrevealed extends StatelessWidget {
  final int row;
  final int col;
  final Function(int, int) onTap;
  final Function(int, int) onLongPress;

  Unrevealed(
      {@required this.row,
      @required this.col,
      @required this.onTap,
      @required this.onLongPress});

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
          decoration: BoxDecoration(
              color: ziggurat, borderRadius: BorderRadius.circular(4.0)),
          width: 10,
          height: 10,
          child: Center(child: Text("")),
        ));
  }
}

class Flagged extends StatelessWidget {
  final int row;
  final int col;
  final Function(int, int) onLongPress;

  Flagged({@required this.row, @required this.col, @required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          onLongPress(row, col);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(4.0)),
          width: 10,
          height: 10,
        ));
  }
}

class Mine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(4.0)),
      width: 10,
      height: 10,
    );
  }
}

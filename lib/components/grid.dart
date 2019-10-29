import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/models/grid_model.dart';
import 'package:minesweeper/utilities/colors.dart';

class Grid extends StatelessWidget {
  final GridModel gridModel;

  final Function(int, int) onTap;
  final Function(int, int) onLongPress;

  Grid(
      {@required this.gridModel,
      @required this.onTap,
      @required this.onLongPress});

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
            final cell = gridModel.cells[row][col];

            return CellWidget(
              cell: cell,
              row: row,
              col: col,
              onTap: onTap,
              onLongPress: onLongPress,
            );
          }),
        ));
  }
}

class CellWidget extends StatelessWidget {
  final Cell cell;
  final int row;
  final int col;
  final Function(int, int) onTap;
  final Function(int, int) onLongPress;
  Color _color;

  // factory CellWidget(
  //     {@required this.cell,
  //     @required this.row,
  //     @required this.col,
  //     @required this.onTap,
  //     @required this.onLongPress}) {

  //   );

  CellWidget(
      {@required this.cell,
      @required this.row,
      @required this.col,
      @required this.onTap,
      @required this.onLongPress}) {
    if (this.cell.revealed) {
      _color = Colors.green;
    } else if (this.cell.mine) {
      _color = Colors.red;
    } 
    else {
      _color = ziggurat;
    }
  }

  _cellText() {
    if (cell.revealed && cell.numMines > 0) {
      return Text("${cell.numMines}");
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
          decoration: BoxDecoration(
              color: _color, borderRadius: BorderRadius.circular(4.0)),
          width: 10,
          height: 10,
          child: Center(child: _cellText()),
        ));
  }
}

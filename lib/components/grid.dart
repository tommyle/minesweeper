import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/components/cell.dart';
import 'package:minesweeper/view_models/grid_view_model.dart';
import 'package:minesweeper/utilities/colors.dart';

class Grid extends StatelessWidget {
  final GridViewModel gridModel;

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
          crossAxisCount: gridModel.cols,
          children: List.generate(gridModel.totalCells, (index) {
            final row = index ~/ gridModel.cols;
            final col = index % gridModel.cols;
            final cellViewModel = gridModel.cells[row][col];

            return Cell(
              cellViewModel: cellViewModel,
              row: row,
              col: col,
              onTap: onTap,
              onLongPress: onLongPress,
              gameState: gridModel.gameState,
            );
          }),
        ));
  }
}

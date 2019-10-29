import 'package:flutter/material.dart';
import 'package:minesweeper/modules/game_bloc.dart';
import 'package:minesweeper/modules/game_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minesweeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider(
          child: GameSceren(title: 'Minesweeper'),
          value: GameBloc(rows: 10, cols: 10, mines: 10)),
    );
  }
}

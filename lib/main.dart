import 'package:flutter/material.dart';
import 'package:minesweeper/modules/game/game_bloc.dart';
import 'package:minesweeper/modules/game/game_screen.dart';
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
          value: GameBloc()),
    );
  }
}

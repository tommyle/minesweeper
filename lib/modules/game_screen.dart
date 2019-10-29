import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper/components/grid.dart';
import 'package:minesweeper/models/grid_model.dart';
import 'package:minesweeper/modules/game_bloc.dart';
import 'package:provider/provider.dart';

class GameSceren extends StatefulWidget {
  GameSceren({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameScerenState createState() => _GameScerenState();
}

class _GameScerenState extends State<GameSceren> {
  GameBloc _gameBloc;

  initBloc(BuildContext context) {
    if (_gameBloc == null) {
      _gameBloc = Provider.of(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    initBloc(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 500,
                height: 500,
                child: StreamBuilder(
                    stream: _gameBloc.gridModelController,
                    builder: (BuildContext context,
                        AsyncSnapshot<GridModel> snapshot) {
                      if (snapshot.hasData) {
                        return Grid(
                          gridModel: snapshot.data,
                          onTap: (i, j) {
                            _gameBloc.reveal(i, j);
                          },
                          onLongPress: (i, j) {
                            // _gameBloc.toggleFlag(i, j);
                          },
                        );
                      } else {
                        return Container();
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

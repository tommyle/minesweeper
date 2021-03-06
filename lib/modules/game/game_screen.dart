import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minesweeper/components/grid.dart';
import 'package:minesweeper/components/settings.dart';
import 'package:minesweeper/models/game_state.dart';
import 'package:minesweeper/view_models/grid_view_model.dart';
import 'package:minesweeper/modules/game/game_bloc.dart';
import 'package:minesweeper/utilities/colors.dart';
import 'package:minesweeper/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

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

  _showSettings() async {
    final difficulty = await showDialog<GameDifficulty>(
        context: context, builder: (BuildContext context) => Settings());

    _gameBloc.newGame(difficulty: difficulty);
  }

  _settingsButton() {
    return GestureDetector(
      onTap: () {
        _showSettings();
      },
      child: Container(
        height: 70,
        width: 50,
        decoration: BoxDecoration(
            color: jaggedIce, borderRadius: BorderRadius.circular(100.0)),
        margin: EdgeInsets.all(12),
        child: Center(child: Icon(Icons.settings)),
      ),
    );
  }

  _leaderBoardButton() {
    return GestureDetector(
      onTap: () {
        html.window.open("https://github.com/tommyle/minesweeper", "git repo");
      },
      child: Container(
        height: 70,
        width: 50,
        decoration: BoxDecoration(
            color: jaggedIce, borderRadius: BorderRadius.circular(100.0)),
        margin: EdgeInsets.all(12),
        child: Center(child: Icon(Icons.star)),
      ),
    );
  }

  _buildFlagsWidget() {
    return Container(
      width: 110,
      height: 70,
      decoration: BoxDecoration(
          color: jaggedIce, borderRadius: BorderRadius.circular(100.0)),
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(6),
      child: Center(
          child: StreamBuilder(
              initialData: "--",
              stream: _gameBloc.flagCountController,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SizedBox(
                        child: Text(
                      "Flags: ${snapshot.data}",
                      style: TextStyle(
                          fontFamily: defaultFont,
                          fontSize: 20,
                          color: Colors.black),
                    )));
              })),
    );
  }

  String _smileyGuyImage(GameState state) {
    if (state == null || state == GameState.InProgress) {
      return "assets/images/normal.png";
    } else if (state == GameState.Win) {
      return "assets/images/win.png";
    } else {
      return "assets/images/lose.png";
    }
  }

  _buildResetButton() {
    return GestureDetector(
      onTap: () {
        _gameBloc.reset();
      },
      child: Container(
        width: 70,
        height: 70,
        child: Center(
            child: StreamBuilder(
                stream: _gameBloc.gameStateController,
                builder:
                    (BuildContext context, AsyncSnapshot<GameState> snapshot) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(_smileyGuyImage(snapshot?.data)),
                      ),
                    ),
                  );
                })),
      ),
    );
  }

  _buildTimerWidget() {
    return Container(
      width: 110,
      height: 70,
      decoration: BoxDecoration(
          color: jaggedIce, borderRadius: BorderRadius.circular(100.0)),
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(6),
      child: Center(
          child: StreamBuilder(
              initialData: "--",
              stream: _gameBloc.timerBloc.elapsedTime,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SizedBox(
                        child: Text(
                      "${snapshot.data}",
                      style: TextStyle(
                          fontFamily: defaultFont,
                          fontSize: 20,
                          color: Colors.black),
                    )));
              })),
    );
  }

  _buildGridWidget() {
    return StreamBuilder(
        stream: _gameBloc.gridModelController,
        builder: (BuildContext context, AsyncSnapshot<GridViewModel> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    width:
                        _gameBloc.cols * (_gameBloc.cols >= 16 ? 28.0 : 44.0),
                    child: Grid(
                      gridModel: snapshot.data,
                      onTap: (i, j) {
                        _gameBloc.reveal(i, j);
                      },
                      onLongPress: (i, j) {
                        _gameBloc.toggleFlag(i, j);
                      },
                    )));
          } else {
            return Container();
          }
        });
  }

  _header() {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
                child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 60.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'MI',
                      style:
                          TextStyle(color: mayaBlue, fontFamily: defaultFont)),
                  TextSpan(
                      text: 'NE',
                      style:
                          TextStyle(color: brinkPink, fontFamily: defaultFont)),
                  TextSpan(
                      text: 'SWEEPER',
                      style: TextStyle(color: raven, fontFamily: defaultFont))
                ],
              ),
            ))));
  }

  _hud() {
    return Container(
      width: 520,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(flex: 2, child: _settingsButton()),
          Flexible(flex: 3, child: _buildFlagsWidget()),
          Flexible(flex: 2, child: _buildResetButton()),
          Flexible(flex: 3, child: _buildTimerWidget()),
          Flexible(flex: 2, child: _leaderBoardButton()),
        ],
      ),
    );
  }

  _instructions() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Text("Tip: Long press to add a flag",
            style: TextStyle(
                color: raven, fontFamily: defaultFont, fontSize: 14)));
  }

  @override
  Widget build(BuildContext context) {
    initBloc(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _header(),
            _hud(),
            _buildGridWidget(),
            _instructions(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/utilities/colors.dart';
import 'package:minesweeper/utilities/constants.dart';

enum GameDifficulty { Easy, Medium, Hard }

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Material(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    height: 165,
                    width: 300,
                    color: jaggedIce,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SettingsButton(
                          text: "Easy (10 mines)",
                          color: mayaBlue,
                          onPressed: () {
                            Navigator.pop(context, GameDifficulty.Easy);
                          },
                        ),
                        SettingsButton(
                          text: "Medium (40 mines)",
                          color: brinkPink,
                          onPressed: () {
                            Navigator.pop(context, GameDifficulty.Medium);
                          },
                        ),
                        SettingsButton(
                          text: "Hard (99 mines)",
                          color: brightSun,
                          onPressed: () {
                            Navigator.pop(context, GameDifficulty.Hard);
                          },
                        )
                      ],
                    ),
                  ),
                ))));
  }
}

class SettingsButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;

  SettingsButton(
      {@required this.text, @required this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: color,
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: TextStyle(
            fontFamily: defaultFont, fontSize: 20, color: Colors.white),
      ),
    );
  }
}

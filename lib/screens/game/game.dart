import 'package:flutter/material.dart';
import 'package:dictionary/constants.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  var pic = 'assets/images/ace.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary Game'),
      ),
      body: Column(children: [
        Container(
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  child: Image.asset(
                    '$pic',
                    height: 200,
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}

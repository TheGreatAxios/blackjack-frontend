import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_one/api.dart';
import 'package:test_one/screens/game.dart';
import 'package:test_one/state.dart';
import 'package:test_one/types/player.dart';
import 'package:test_one/types/table.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final Api _api = Api.instance;
  final GameState _gameState = GameState.instance;
  late String page = 'Welcome';
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _api.wsStream.listen((dynamic e) {
      Map<String, dynamic> event = Map.from(jsonDecode(e));
      print(event['action']);
      print(event['action'].runtimeType);
      print("Event: ${event}");
      if (event['action'].toString() == 'USER_ADD_LOCAL') {
        final Player _player = Player.fromJson(event['player']);
        final GameTable _table = GameTable.fromJson(event['table']);
        _gameState.playerSubject.sink.add(_player);
        _gameState.tableSubject.sink.add(_table);
        _api.connectUser(_table.id.toString(), _player.id.toString());
        setState(() {
          page = 'Game';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (page == 'Welcome') {
      return Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                children: <Widget>[
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        labelText: "Username"
                    ),
                  ),
                  ElevatedButton(
                    child: const Text("Join Table"),
                    onPressed: () {
                      _api.createUser(_controller.value.text);
                    },
                  )
                ]
            )
        )
      );
    } else {
      return AwesomeButton();
    }
  }
}
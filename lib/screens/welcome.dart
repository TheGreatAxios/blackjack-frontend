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
    _api.addSocketStream();
    _api.wsStream.listen((dynamic e) {
      if (e.runtimeType == String && e == '"Sorry, the table is full"') {
        setState(() {
          page = 'noRoom';
        });
        Future.delayed(const Duration(seconds: 5), () => {
          setState(() {
            page = 'Welcome';
          })
        });
      } else {
        Map<String, dynamic> event = Map.from(jsonDecode(e ));
        final GameTable _table = GameTable.fromJson(event);
        _gameState.tableSubject.sink.add(_table);
        if (_gameState.tableSubject.value.playerOne.name ==
            _controller.value.text) {
          setState(() {
            page = 'game';
          });
          _gameState.playerName.sink.add(_controller.value.text);
        } else if (_gameState.tableSubject.value.playerTwo.name ==
            _controller.value.text) {
          setState(() {
            page = 'game';
          });
          _gameState.playerName.sink.add(_controller.value.text);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (page == 'Welcome') {
      return Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/pictures/leopardHome.jpg',
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          alignment: Alignment.bottomCenter,
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 100,
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              // border: OutlineInputBorder(),
                                labelText: "Username"),
                          ),
                        ),
                        Container(
                          height: 50,
                          child: ElevatedButton(
                            child: const Text("Join Table"),
                            onPressed: () {
                              _api.createUser(_controller.value.text);
                            },
                          ),
                        )
                      ]
                    )
                    //),
                  ),
                  // Positioned(
                  //   top: 650,
                  //   left: 590,
                  //   child:
                  //   // ),
                  // ),
                ],
                // mainAxisAlignment: MainAxisAlignment.center,
              )));
    } else if (page == 'game') {
      return AwesomeButton();
    } else {
      return Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/pictures/leopardHome.jpg',
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const Text(
                              'Table full. Try again later.',
                              style: TextStyle(
                                  fontSize: 32
                              )
                          )
                      )
                  )
                ]
            ),
          )
      );
    }
  }
}

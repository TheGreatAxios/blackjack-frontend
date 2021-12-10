import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_one/api.dart';
import 'package:test_one/types/player.dart';
import 'package:test_one/types/table.dart';

class LocalPlayerWidget extends StatelessWidget {
  const LocalPlayerWidget({Key? key, required this.player, required this.api, required this.playerNumber, required this.table }) : super(key: key);

  final Player player;
  final Api api;
  final int playerNumber;
  final GameTable table;

  @override
  Widget build(BuildContext context) {
    print("Player: ${player.isReady}");
    return Stack(
        children: <Widget>[
          Positioned(
              top: 15,
              right: 15,
              child: Text(
                  "YOU${_getCurrentHandValue(player.currentHandValue)}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                  )
              )
          ),
          Positioned(
            top: 50,
            right: 15,
            child: SizedBox(
              width: 250,
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    _readyUp(player, api, playerNumber),
                    _deal(player, api, playerNumber, table),
                    _hit(player, api, playerNumber, table),
                    _stand(player, api, playerNumber, table),
                    // _bet(widget.player, widget.api, betController, widget.playerNumber)
                  ]
              ),
            )
          ),
          Positioned(
              top: 5,
              left: 15,
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: player.currentHand.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Container(
                        child: Image.asset('assets/Cards/${player.currentHand[index]}.png'),
                      );
                    }
                ),
              )
          ),
          getResult(table, player, context),
        ]
    );
  }
}

Widget getResult(GameTable table, Player player, BuildContext ctx) {
  print("Table GO: ${table.isGameOver}");
  String message = '';
  if (table.isGameActive) {
    return Container();
  } else if (table.isGameOver) {
    print(player.hasBlackjack!);
    print(player.hasBusted!);
    print(player.hasPushed!);
    print(player.hasWon!);
    if (player.hasBlackjack!) {
      message = "You have blackjack! You win!";
    } else if (player.hasBusted!) {
      message = "Sorry, you busted. Dealer wins.";
    } else if (player.hasPushed! && !player.hasWon!) {
      message = "You pushed with the dealer";
    } else if (player.hasWon!) {
      message = "You win!";
    } else if (!player.hasWon!) {
      message = "You Lose";
    }
    print("Message: ${message}");
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 25,
          color: Colors.black,
          width: MediaQuery.of(ctx).size.width,
          alignment: Alignment.center,
          child: Text(
              message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            )
          )
        )
    );
  } else {
    return Container();
  }
}

String _getCurrentHandValue(int _value) {
  return _value == -1 ? '' : ' | $_value';
}

Widget _readyUp(Player _player, Api api, int playerNumber) {
  if (!_player.isReady) {
    return ElevatedButton(
      child: const Text("Ready Up"),
      onPressed: () {
        _sendMessage({ "action": "READY_UP", "playerNumber": playerNumber}, api);
      },
    );
  } else {
    return Container();
  }
}

Widget _deal(Player _player, Api api, int playerNumber, GameTable _table) {
  if (_table.playerOne.name.isNotEmpty && _table.playerTwo.name.isNotEmpty) {
    return Container();
  } else {
    if (!_table.isGameActive && _player.isReady) {
      return ElevatedButton(
        child: const Text("    Deal     "),
        onPressed: () {
          _sendMessage({ "action": "DEAL", "playerNumber": playerNumber}, api);
        },
      );
    } else {
      return Container();
    }
  }
}

Widget _hit(Player _player, Api api, int playerNumber, GameTable _table) {
  if (_table.isGameActive) {
    if (_player.isActive) {
      return ElevatedButton(
        child: const Text("        Hit         "),
        onPressed: () {
          _sendMessage({ "action": "HIT", "playerNumber": playerNumber}, api);
        },
      );
    }
  }
  return Container();
}

Widget _stand(Player _player, Api api, int playerNumber, GameTable _table) {
  if (_table.isGameActive) {
    if (_player.isActive) {
      return ElevatedButton(
        child: const Text("      Stand      "),
        onPressed: () {
          _sendMessage({ "action": "STAND", "playerNumber": playerNumber}, api);
        },
      );
    }
  }
  return Container();
}



Widget _bet(Player _player, Api api, TextEditingController _controller, int playerNumber) {
  // if (_player.isReady && _player.currentBet == 0) {
    return SizedBox(
      width: 100,
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Bet #'
              ),
            ),
          ),
          if (_controller.value.text.isNotEmpty) IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              var _amount = int.parse(_controller.value.text);
              if (_amount.runtimeType == int) {
                if (_amount > 0) {
                  _sendMessage({ "action": "PLACE_BET", "playerNumber": playerNumber, "betAmount": _amount }, api);
                }
              }
            },
          ),
        ]
      )
    );
  // }
  return Container();
}

void _sendMessage(Map<String, dynamic> _data, Api api) {
  api.ws.sink.add(jsonEncode(_data));
}
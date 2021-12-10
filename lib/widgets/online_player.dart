import 'package:flutter/material.dart';
import 'package:test_one/types/player.dart';

class OnlinePlayerWidget extends StatelessWidget {
  const OnlinePlayerWidget({Key? key, required this.player }) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Positioned(
              bottom: 15,
              right: 15,
              child: Text(
                  "${player.name.toUpperCase()}${_getCurrentHandValue(player.currentHandValue)}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  )
              )
          ),
          Positioned(
              top: 35,
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
          )
        ]
    );
  }
}

String _getCurrentHandValue(int _value) {
  return _value == -1 ? '' : ' | $_value';
}
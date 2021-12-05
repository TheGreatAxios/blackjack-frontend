
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:restart_app/restart_app.dart';
import 'package:test_one/screens/game.dart';
import 'package:test_one/screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}




  // Map<int, dynamic> _playerCards = {
  //   0: {
  //     'cardNumber': 5,
  //     'cardType': 'Spade',
  //     'cardColor': red,
  //     'isVisible': false
  //   }
  // };
  //
  // List<Widget> _generateCards(List<int> cards) {
  //   List<Widget> _childrenToReturn = <Widget>[];
  //   cards.forEach((int element) {
  //     Positioned _p = Positioned(
  //       left: secondDealerCardX + 40,
  //       top: secondDealerCardY,
  //       child: Image.asset(playingCards[AICard3]),
  //       height: 100,
  //     );
  //   });


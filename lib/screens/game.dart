
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:restart_app/restart_app.dart';
import 'package:test_one/api.dart';
import 'package:test_one/state.dart';
import 'package:test_one/types/player.dart';
import 'package:test_one/types/table.dart';
import 'package:test_one/widgets/dealer.dart';
import 'package:test_one/widgets/local_player.dart';
import 'package:test_one/widgets/online_player.dart';

class AwesomeButtonState extends State<AwesomeButton> {

  final Api _api = Api.instance;
  final GameState _state = GameState.instance;
  final TextEditingController _localPlayerBetController = TextEditingController();
  @override
  void initState() {
    _api.wsStream.asBroadcastStream().listen((dynamic e) {
      Map<String, dynamic> event = Map.from(jsonDecode(e));
        final GameTable _table = GameTable.fromJson(event);
        _state.tableSubject.sink.add(_table);
    });
    super.initState();
  }

  int _getCardSum(List<String> cards) {
    int res = 0;
    bool containsAce = false;
    cards.forEach((String element) {
      String val = element[0];
      List<String> _faces = ['K', 'Q', 'J'];
      if (_faces.contains(val)) {
        res += 10;
      } else if (val == 'A') {
        containsAce = true;
        res += 11;
        if (res > 21) {
          res -= 10;
        }
      } else {
        res += int.parse(val);
        if (containsAce && res > 21) {
          res -= 10;
        }
      }
    });


    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //TITLE ON TOP
            title: const Text("Black Jack!"), backgroundColor: Colors.black,
            centerTitle: true
        ),

        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<GameTable>(
            stream: _state.tableStream,
            builder: (BuildContext ctx, AsyncSnapshot<GameTable> snapshot) {
              if (snapshot.hasData) {

                GameTable _table = snapshot.data!;
                Player _localPlayer = _table.playerOne.name == _state.playerName.value ? _table.playerOne : _table.playerTwo;
                print("LP: ${_localPlayer.isReady}");
                int _localPlayerNumber = _table.playerOne.name == _state.playerName.value ? 1 : 2;
                Player _onlinePlayer = _table.playerOne.name == _state.playerName.value ? _table.playerTwo : _table.playerOne;
                int _onlinePlayerNumber = _table.playerOne.name == _state.playerName.value ? 2 : 1;
                return Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: DealerWidget(dealer: _table.dealer)
                      )
                    ),
                    Positioned(
                        top: 250,
                        left: 0,
                        child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                 bottom: BorderSide(
                                   color: Colors.black,
                                   width: 2,
                                 )
                              )
                            ),
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: LocalPlayerWidget(player: _localPlayer, api: _api, playerNumber: _localPlayerNumber, table: _table)
                        )
                    ),
                    if (_onlinePlayer.name.isNotEmpty) Positioned(
                        top: 500,
                        left: 0,
                        child: Container(
                            color: Colors.yellow,
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: OnlinePlayerWidget(player: _onlinePlayer)
                        )
                    )
                  ]
                );
//                 print("Status: ${_table.currentHand.status}");
//                 print("GS: ${_table.gameStatus}");
//                 return Stack(
//                   children: <Widget>[
//
//                     Positioned(
//                       top: 50,
//                       right: 50,
//                       child: Text(
//                         _table.currentHand.status != -1 ? 'Player ${_table.currentHand.status}\'s turn' : 'Dealer\'s Turn'
//                       )
//                     ),
//
//
//                     Container(
//                       decoration: BoxDecoration(
//                         color:Colors.green,
//                       ),
//                     ),
//                     Positioned(
//                         right: 50,
//                         top: 20,
//                         child: Text('You have: ${_table.players[0].balance} coins',
//                           style: TextStyle(fontSize: 30),)
//                     ),
//
//
//                     //WHAT HAPPENS IF YOU WIN AND HOW MUCH YOU GAIN
//                     // DIPLAYING CARDS TO THE USER
//                     //Displays the first two cards for the player
//                     Positioned(
//                       bottom: 50,
//                       left: 50,
//                       child: Center(
//                         child: Container(
//                           width: 900,
//                           height: 210,
//                           child: ListView.builder(
//                               physics: NeverScrollableScrollPhysics(),
//                               scrollDirection: Axis.horizontal,
//                               itemCount: snapshot.data?.currentHand.players[0].cards.length,
//                               itemBuilder: (BuildContext ctx, int index) {
//                                 return Container(
//
//                                     child: Image.asset('assets/Cards/${snapshot.data?.currentHand.players[0].cards[index]}.png'),
//
//                                 );
//
//                               }
//                           ),
//                         )
//                       )
//                     ),
//
//
//                     Positioned(
//                         right: 500,
//                         top: 20,
//                         child: Text("Your total is: ${_getCardSum(_table.currentHand.players[0].cards)}", style: TextStyle(fontSize: 40))
//                     ),
//                     //AI CARDS
//                     //AI FIRST CARDs
//                     Positioned(
//                       top: 60,
//                       child: Container(
//                         height: 210,
//                         width: 700,
//                         child: ListView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             scrollDirection: Axis.horizontal,
//                             itemCount: snapshot.data?.currentHand.dealer.length,
//                             itemBuilder: (BuildContext ctx, int index) {
//                               if (index == 0 && _table.currentHand.status != -1) {
//                                 return Container(
//                                     child: Image.asset(
//                                         'assets/Cards/card_back.png',
//                                         height: 100,
//                                         width: 250,
//                                     )
//                                 );
//                               }
//                               return Container(
//                                   child: Image.asset(
//                                     'assets/Cards/${snapshot.data?.currentHand.dealer[index]}.png',
//                                     height: 100,
//                                     width: 150,
//                                   )
//                               );
//                             }
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         //if(blah blah) then you busted and then create if statments for all three cases
//                         child: Text(_table.currentHand.result, style: TextStyle(fontSize: 40),)
//                       ),
//                     ),
//
//
// //BUTTON IF HIT
//                     Positioned(
//                       right: 50,
//                       bottom: 225,
//                       child: Container(
//                         width: 300,
//                         height: 150,
//                         child: ElevatedButton(
//                             // onPressed: onHit,
//                             onPressed: () {
//                               _api.userHit(_table.id.toString(), '0');
//                             },
//                             child: Text("Hit")
//                         ),
//                       ),
//                     ),
//                     //BUTTON IF STAY
//                     Positioned(
//                       right: 50,
//                       bottom: 50,
//                       child: Container(
//                         width: 300,
//                         height: 150,
//                         color: Colors.blue,
//                         child: RaisedButton(onPressed: (){
//                           _api.userStay(_table.id.toString(), '0');
//                         },
//                             child: Text("Stay")
//                         ),
//                       ),
//                     ),
//                     //BUTTON IF DEAL
//                     if (_table.gameStatus == 'RESET') Positioned(
//                       // left: dealerButtonX,
//                       // top: dealerButtonY,
//                       right: 50,
//                       bottom: 400,
//                       child: Container(
//                         width: 300,
//                         height: 150,
//                         color: Colors.redAccent,
//                         child: ElevatedButton(
//                           // onPressed: onDeal,
//
//                             onPressed: () {
//                               _api.startGame(_table.id.toString());
//                             },
//                             child: const Text('Deal')
//                         ),
//                       ),
//                     ),

                    //button to redeal
                    // Positioned(
                    //   left: playAgainButtonX,
                    //   top: playAgainButtonY,
                    //   child: Container(
                    //     width: 150,
                    //     height: 50,
                    //     child: ElevatedButton(
                    //         onPressed: () {},
                    //         child: Text("Press to play again ")
                    //     ),
                    //   ),
                    // ),
//BETTING
                    //INPUT BETTING BOX

                    //
                    //
                    //include an if statment that checks if its the users turn
             // if(//something that checks if its their turn or not)
             //   Positioned(
             //     right: 50,
             //          top: 75,
             //          child: Container(
             //
             //            child: Text("It is your turn", style:
             //            TextStyle(fontSize: 20),),
             //          ),
             //        ),

                    // if (_state.playerSubject.value.id == _table.players[_table.currentHand.status].id) Positioned(
                    //   right: 50,
                    //   top: 140,
                    //   child: Container(
                    //     width: 200,
                    //     height: 50,
                    //
                    //     child: TextField(
                    //
                    //       decoration: const InputDecoration(
                    //         border: OutlineInputBorder(),
                    //
                    //         hintText: 'Enter a bet',
                    //
                    //       ),
                    //
                    //       onChanged: (input) {
                    //         _api.placeBet(_table.id.toString(), '0', int.parse(input));
                    //         // setState(() {
                    //         //   startClick = true;
                    //         //   bet = double.parse(input);
                    //         // });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // //DISPLAYING WHAT HAS BEEN BET
                    // if (_state.playerSubject.value.id == _table.players[_table.currentHand.status].id) Positioned(
                    //   right: 50,
                    //   top: 125,
                    //   child: Text('${_table.currentHand.players[0].bets.last}'),
                    // ),

                    // Idea to make the restart screen go when your coins drop below zero
                    // Positioned(
                    //   left: restartX,
                    //   top: restartY,
                    //   child: Container(
                    //     width: 150,
                    //     height: 50,
                    //
                    //     child: RaisedButton(
                    //       child: Text("Play again"),
                    //       onPressed: () async {
                    //         Restart.restartApp();
                    //       },
                    //     ),
                    //   ),
                    // ),

                    // Positioned(
                    //   left: restartX,
                    //   top: restartY + 50,
                    //   child: Text('You are lost and are out of coins! Would you like to play again'),
                    // ),
                    //
                    // Center(
                    //   child: Container(
                    //     height: titleScreenH,
                    //     width: titleScreenH,
                    //     color: Colors.black,
                    //     child: Image.asset('assets/pictures/leopardHome.jpg'),
                    //
                    //     // child: Text('Welcome to Black Jack',
                    //     // style: TextStyle(fontSize: 50),
                    //     // ),
                    //   ),
                    // ),
                    //
                    // Positioned(
                    //   top: titleScreenTextY,
                    //   left: titleScreenTextX,
                    //   child: Text("A room has been joined",
                    //       style: TextStyle(fontSize: 40),),
                    // ),
                    //
                    // Positioned(
                    //   top: playButtonY,
                    //   right: playButtonX,
                    //     child: RaisedButton.icon(onPressed:()
                    //         {
                    //         setState(() {
                    //         titleScreenH = 0;
                    //         playButtonX = 1000;
                    //         playButtonY = 1000;
                    //         titleScreenTextY = 1000;
                    //         titleScreenTextX = 1000;
                    //         }
                    //         );
                    //         },
                    //       icon: Icon(Icons.play_circle),
                    //       label: Text("Play"),
                    //
                    //   ),
                    // ),


                //   ], //stay inside these when creating new buttons and images
                // );
                return Container(child: Text("GAME"));
              }
              return CircularProgressIndicator();
            }
          )
        )
    );
  }

}

class AwesomeButton extends StatefulWidget{
  @override
  AwesomeButtonState createState() => new AwesomeButtonState();

}
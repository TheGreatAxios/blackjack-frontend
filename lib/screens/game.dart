
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:restart_app/restart_app.dart';
import 'package:test_one/api.dart';
import 'package:test_one/state.dart';
import 'package:test_one/types/table.dart';

class AwesomeButtonState extends State<AwesomeButton> {

  final Api _api = Api.instance;
  final GameState _state = GameState.instance;

  @override
  void initState() {
    _api.wsStream.asBroadcastStream().listen((dynamic e) {
      Map<String, dynamic> event = Map.from(jsonDecode(e));
      // print(event['action']);
      // print(event['action'].runtimeType);
      // print("Event: ${event}");
      // if (event['action'].toString() == 'USER_ADD_LOCAL') {
      //   final Player _player = Player.fromJson(event['player']);
        final GameTable _table = GameTable.fromJson(event['table']);
      //   _gameState.playerSubject.sink.add(_player);
        _state.tableSubject.sink.add(_table);
      //   _api.connectUser(_table.id.toString(), _player.id.toString());
      //   setState(() {
      //     page = 'Game';
      //   });
      // }
    });
    super.initState();
  }

  int counter = 0;

  double firstCardX = 1000;
  double firstCardY = 2000;
  double secondCardX = 1000;
  double secondCardY = 2000;
  double thirdCardX = 1000;
  double thirdCardY = 2000;

  double firstDealerCardX = 1000;
  double firstDealerCardY = 2000;
  double secondDealerCardX = 1000;
  double secondDealerCardY = 2000;
  double thirdDealerCardX = 1000;
  double thirdDealerCardY = 2000;
  double fourthDealerCardX = 1000;
  double fourthDealerCardY = 2000;
  bool forthDealerCardVisibility = false;

  double dealerButtonX = 10;
  double dealerButtonY = 10;
  double playAgainButtonX = 1000;
  double playAgainButtonY = 1000;

  double titleScreenH = 10000;
  double playButtonX = 740;
  double playButtonY =400;

  double restartX = 2000;
  double restartY = 2000;

  double youBustedX = 2000;
  double youBustedY = 2000;
  double resultX = 2000;
  double resultY = 2000;

  int sumOfCards = 0;
  int sumOfAICards = 0;

  int card1Value = 0;
  int card2Value = 0;
  int card3Value = 0;
  int card4Value = 0;
  int card5Value = 0;
  int cardValue = 0;

  int cardValueAI = 0;
  int card1ValueAI = 0;
  int card2ValueAI = 0;
  int card3ValueAI = 0;
  int card4ValueAI = 0;
  int card5ValueAI = 0;

  double bet = 0;
  double userCoins = 100;

  bool dealButton = true;
  bool clicking = true;
  bool gameReset = false;
  bool startClick = false;
  bool dealClick = false;

  int called = 0;
  int numberOfCards = 0;

  List<int> cards = <int>[];
  int card1 = Random().nextInt(52);
  int card2 = Random().nextInt(52);
  int card3 = Random().nextInt(52);
  int card4 = Random().nextInt(52);
  int card5 = Random().nextInt(52);

  int AICard1 = Random().nextInt(52);
  int AICard2 = Random().nextInt(52);
  int AICard3 = Random().nextInt(52);
  int AICard4 = Random().nextInt(52);
  int AICard5 = Random().nextInt(52);


  String backOfCard = 'assets/images/backOfCard.jpg';
  String result = '';

  List<int> AI = [];
  int i = 0;

  int buttDial = 0;
  //putting all cards in an array
  List<String> playingCards =['assets/c/2_of_clubs.png','assets/c/2_of_diamonds.png','assets/c/2_of_hearts.png','assets/c/2_of_spades.png',
    'assets/c/3_of_hearts.png','assets/c/3_of_diamonds.png',
    'assets/c/3_of_spades.png','assets/c/3_of_clubs.png','assets/c/4_of_clubs.png','assets/c/4_of_diamonds.png','assets/c/4_of_spades.png','assets/c/4_of_hearts.png','assets/c/5_of_clubs.png',
    'assets/c/5_of_diamonds.png','assets/c/5_of_spades.png','assets/c/5_of_hearts.png',
    'assets/c/6_of_clubs.png','assets/c/6_of_diamonds.png','assets/c/6_of_spades.png','assets/c/6_of_hearts.png','assets/c/7_of_clubs.png','assets/c/7_of_diamonds.png','assets/c/7_of_spades.png','assets/c/7_of_hearts.png',
    'assets/c/8_of_clubs.png','assets/c/8_of_diamonds.png','assets/c/8_of_spades.png','assets/c/8_of_hearts.png','assets/c/9_of_clubs.png',
    'assets/c/9_of_diamonds.png','assets/c/9_of_spades.png','assets/c/9_of_hearts.png',
    'assets/c/10_of_clubs.png','assets/c/10_of_diamonds.png','assets/c/10_of_spades.png','assets/c/10_of_hearts.png','assets/c/jack_of_diamonds2.png','assets/c/jack_of_clubs2.png'
    ,'assets/c/jack_of_hearts2.png','assets/c/jack_of_spades2.png',
    'assets/c/queen_of_diamonds2.png','assets/c/queen_of_clubs2.png','assets/c/queen_of_hearts2.png','assets/c/queen_of_spades2.png'
    ,'assets/c/king_of_diamonds2.png','assets/c/king_of_clubs2.png','assets/c/king_of_hearts2.png','assets/c/king_of_spades2.png'
    ,'assets/c/ace_of_diamonds.png','assets/c/ace_of_clubs.png','assets/c/ace_of_hearts.png','assets/c/ace_of_spades.png',];

  AssetImage getCard(int cardNumber, String cardType) {
    return AssetImage(playingCards[playingCards.indexOf(
        'assets/c/${cardNumber}_of_${cardType}.png')]);
  }
  int ValueOfCard(int value) {
    //Assigning value of cards then returning them
    value = value +1;
    if ( value <= 4){
      value = 2;
    }if (value < 8 && value >= 5){
      value = 3;
    }if (value <= 12 && value >= 9){
      value = 4;
    }if (value <= 16 && value >= 13){
      value = 5;
    }if (value <= 20 && value >= 17){
      value = 6;
    }if (value <= 24 && value >= 21){
      value = 7;
    }if (value <= 28 && value >= 25){
      value = 8;
    }if (value <= 32 && value >= 29){
      value = 9;
    }if (value <= 46 && value >= 33) {
      value = 10;
    }if (value <= 52 && value >= 47) {
      //gonna have to figure out to make it 1 instead of 11
      value = 11;
    }
    return value;
  }

  int sumOfCard(int value) {
    //getting the sum of the cards
    //maybe make a counter that goes into a for loop that checks if there are any aces
    //then checks if the sumOfCards is greater then 21 and subtracts ten from it
    card1Value = ValueOfCard(card1);
    card2Value = ValueOfCard(card2);
    cardValue = ValueOfCard(value);

    if (value == 100){
      return sumOfCards = card1Value + card2Value;
    }
    if(value == 200){
      return sumOfCards;
    }
    // if (sumOfCards > 21 && cardValue == 11 || card2Value == 11 || card1Value == 11){
    //   sumOfCards = sumOfCards - 10;
    // }
    // sumOfCards = sumOfCards + cardValue;
    return sumOfCards + cardValue;
  }


//getting sum of cards when you add a card too it
  int AddSumOfAICard(int value) {


    card1ValueAI = ValueOfCard(AICard1);
    card2ValueAI = ValueOfCard(AICard2);
    cardValueAI = ValueOfCard(value);

    if (value == 100){
      return sumOfAICards = card1ValueAI + card2ValueAI;
    }
    if(value == 200){
      return sumOfAICards;
    }
    return sumOfAICards + cardValueAI;
  }


  //getting the the sum of the ai cards
  int sumOfAI() {//need to change


    // AI.add(ValueOfCard(AICard1));
    // AI.add(ValueOfCard(AICard2));
    AI.add(ValueOfCard(AICard3));
    AI.add(ValueOfCard(AICard4));
    AI.add(ValueOfCard(AICard5));

    if(buttDial == 0){
      sumOfAICards = AddSumOfAICard(100);

      while (sumOfAICards < 17) {
        sumOfAICards = AI[i] + sumOfAICards;
        numberOfCards = numberOfCards + 1;
        i++;
      }
      buttDial++;
    }
    //sumOfAICards = sumOfAICards;
    return sumOfAICards;
  }

  onHit() {
    setState(() {
      if (dealClick) {
        counter ++;

        //idea for assining value to index of cards
        if (counter == 0 && clicking) {
          sumOfCards = sumOfCard(100);
        }
        if (counter == 1 && clicking) {
          secondCardX = firstCardX;
          secondCardY = firstCardY;
          sumOfCards = sumOfCard(card3);
          if (sumOfCards > 21){
            onBust();
          }
        }
        if (counter == 2 && clicking) {
          thirdCardX = firstCardX;
          thirdCardY = firstCardY;
          sumOfCards = sumOfCard(card4);
          if (sumOfCards > 21){
            onBust();
          }
        }
      }
    });
  }
  userBroke(){
    setState(() {
      if (userCoins <= 0){
        restartY = 350;
        restartX = 450;
      }
    });
  }

  onBust(){
    setState(() {
      resultX = 450;
      resultY = 150;
      result = 'bust';
      userCoins = userCoins - bet;
      userBroke();
      reDealButton();

    });
  }
  onLost(){
    setState(() {
      userCoins = userCoins - bet;
      result = 'You lost';
      userBroke();
      reDealButton();
    });
  }
  onWin(){
    setState(() {
      bet = bet * 2;
      userCoins = userCoins + (bet);
      result = 'You won';
      reDealButton();
    });
  }
  reDealButton(){
    setState(() {
      if(userCoins > 0) {
        playAgainButtonX = 700;
        playAgainButtonY = 400;
      }
    });
  }

  onStay() {
    setState(() {
      if(dealClick){
        //maybe write a class that checks

        sumOfAICards = sumOfAI();
        sumOfCards = sumOfCard(200);
        resultX = 450;
        resultY = 150;
        backOfCard = playingCards[AICard1];
        if (sumOfAICards == 21) {
          onLost();
        }

        if (sumOfCards <= 20 && sumOfAICards <= 20) {
          if (sumOfCards > sumOfAICards) {
            onWin();
          }
          if (sumOfCards < sumOfAICards) {
            //i can get rid of these beause its the same as youWon
            onLost();
          }
        }
//if the for loop runs numberOfCards amount of times then display these cards
        if (numberOfCards == 1) {
          secondDealerCardX = firstDealerCardX;
          secondDealerCardY = firstDealerCardY;
        }
        if (numberOfCards == 2) {
          thirdDealerCardX = firstDealerCardX;
          thirdDealerCardY = firstDealerCardY;
        }
        if (numberOfCards == 3) {
          fourthDealerCardX = firstDealerCardX;
          // fourthDealerCardY = firstDealerCardY;
          forthDealerCardVisibility = true;
        }

        if (sumOfCards < 21) {
          if (sumOfCards > 21) {
            onLost();
          }
          if (sumOfAICards > 21) {
            onWin();
          }
          if (sumOfCards == sumOfAICards) {
            result = 'You tied';
            userCoins = userCoins;
            reDealButton();
            //need to add postition args for title
          }
        }
        if (sumOfCards > 21) {
          onLost();
        }
        if (sumOfCards == 21){
          onWin();
        }
        //if the dealer hits once display that card

      }
      //write a method that will calculate resutlts
    });
  }
  onDeal() {
    // _api.deal();
    // setState(() {
    //
    //
    //   //sumOfCard(100);
    //   if(startClick) {
    //     dealClick = true;
    //
    //     dealerButtonX = 1000;
    //     dealerButtonY = 1000;
    //
    //     firstCardX = firstCardX - 550;
    //     firstCardY = firstCardY / 100 + 50;
    //
    //     firstDealerCardX = firstDealerCardX - 550;
    //     firstDealerCardY = firstDealerCardY / 100 + 50;
    //     if (sumOfCard(100) == 21) {
    //       resultX = 450;
    //       resultY = 150;//maybe put this in methods onWin and onLose
    //       result = 'Jolly G you got 21! You win';
    //       bet = (bet * 2.5);
    //       userCoins = userCoins + bet;
    //       reDealButton();
    //     }
    //     if (AddSumOfAICard(100) == 21) {
    //       resultX = 450;
    //       resultY = 150;
    //       result = 'Jolly G the dealer got 21! You lose';
    //       userCoins = userCoins - bet;
    //       backOfCard = playingCards[AICard1];
    //       reDealButton();
    //     }
    //   }
    //   userBroke();
    // });
  }
  restartGame() {
    setState(() {
      counter = 0;

      firstCardX = 1000;
      firstCardY = 2000;
      secondCardX = 1000;
      secondCardY = 2000;
      thirdCardX = 1000;
      thirdCardY = 2000;

      firstDealerCardX = 1000;
      firstDealerCardY = 2000;
      secondDealerCardX = 1000;
      secondDealerCardY = 2000;
      thirdDealerCardX = 1000;
      thirdDealerCardY = 2000;
      fourthDealerCardX = 1000;
      fourthDealerCardY = 2000;

      dealerButtonX = 10;
      dealerButtonY = 10;
      playAgainButtonX = 1000;
      playAgainButtonY = 1000;

      restartX = 2000;
      restartY = 2000;

      youBustedX = 2000;
      youBustedY = 2000;
      resultX = 2000;
      resultY = 2000;

      sumOfCards = 0;
      sumOfAICards = 0;

      card1Value = 0;
      card2Value = 0;
      card3Value = 0;
      card4Value = 0;
      card5Value = 0;
      cardValue = 0;

      cardValueAI = 0;
      card1ValueAI = 0;
      card2ValueAI = 0;
      card3ValueAI = 0;
      card4ValueAI = 0;
      card5ValueAI = 0;

      bet = 0;
      // userCoins = 100;

      dealButton = true;
      clicking = true;
      gameReset = false;

      called = 0;
      numberOfCards = 0;


      card1 = Random().nextInt(52);
      card2 = Random().nextInt(52);
      card3 = Random().nextInt(52);
      card4 = Random().nextInt(52);
      card5 = Random().nextInt(52);

      AICard1 = Random().nextInt(52);
      AICard2 = Random().nextInt(52);
      AICard3 = Random().nextInt(52);
      AICard4 = Random().nextInt(52);
      AICard5 = Random().nextInt(52);


      backOfCard = 'assets/images/backOfCard.jpg';
      result = '';

      AI = [];
      i = 0;

      buttDial = 0;
    });
  }


  /*void initState() {
    _card.loadCardImage();
    super.initState();
  }
*/

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
            title: Text("Black Jack!"), backgroundColor: Colors.black,
            centerTitle: true
        ),

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<GameTable>(
            stream: _state.tableStream,
            builder: (BuildContext ctx, AsyncSnapshot<GameTable> snapshot) {
              if (snapshot.hasData) {

                GameTable _table = snapshot.data!;
                print("Timer: ${_table.timer}");
                return Stack(
                  children: <Widget>[

                  if (_table.timer != 0) Positioned(
                      top: 50,
                      right: 50,
                      child: Text(
                        '${_table.timer / 1000}',
                        style: TextStyle(
                          color: Colors.white
                        )
                      )
                  ),
                    if (_table.timer == 0) Positioned(
                      top: 50,
                      right: 50,
                      child: Text(
                        _table.currentHand.status != -1 ? 'Player ${_table.currentHand.status}\'s turn' : 'Dealer\'s Turn'
                      )
                    ),
// IF YOU LOSE AND HOW MUCH YOU LOST
//                     Container(
//                       height: 10000,
//                       width: 10000,
//                       color: Colors.black,
//
//                     ),
                    // Positioned(
                    //   child: Center(
                    //     child: Image.asset('assets/pictures/leopardHome.jpg',
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //     right: resultX,
                    //     top:  resultY,
                    //     child: Text('${result}',
                    //       style: TextStyle(fontSize: 50),)
                    // ),

                    //DISPLAY THE USER COINS ON SCREEN

                    Positioned(
                        right: 200,
                        top: 350,
                        child: Text('You have: ${userCoins} coins',
                          style: TextStyle(fontSize: 25),)
                    ),


                    //WHAT HAPPENS IF YOU WIN AND HOW MUCH YOU GAIN
                    // DIPLAYING CARDS TO THE USER
                    //Displays the first two cards for the player
                    Positioned(
                      bottom: 50,
                      child: Center(
                        child: Container(
                          width: 500,
                          height: 300,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.currentHand.players[0].cards.length,
                              itemBuilder: (BuildContext ctx, int index) {
                                return Container(
                                    child: Image.asset('assets/Cards/${snapshot.data?.currentHand.players[0].cards[index]}.png')
                                );

                              }
                          ),
                        )
                      )
                    ),
                    // Positioned(
                    //   left: firstCardX,
                    //   bottom: firstCardY,
                    //   //child: _card.asset,
                    //   child: Image.asset(playingCards[card1]),
                    //   height: 100,
                    // ),
                    //
                    // //Displays the second card that the player is orinally given
                    // Positioned(
                    //   left: firstCardX + 20,
                    //   bottom: firstCardY,
                    //   child: Image.asset(playingCards[card2]),
                    //   height: 100,
                    // ),
                    // //image when the user presses hit for the first t
                    // Positioned(
                    //   left: secondCardX + 40,
                    //   bottom: secondCardY,
                    //   child: Image.asset(playingCards[card3]),
                    //   height: 100,
                    // ),
                    //
                    // Positioned(
                    //   left: thirdCardX + 60,
                    //   bottom: thirdCardY,
                    //   child: Image.asset(playingCards[card4]),
                    //   height: 100,
                    // ),


                    Positioned(
                        right: 720,
                        bottom: 50,
                        child: Text("Your total is: ${_getCardSum(_table.currentHand.players[0].cards)}")
                    ),
                    //AI CARDS
                    //AI FIRST CARDs
                    Positioned(
                      top: 50,
                      child: Container(
                        height: 300,
                        width: 500,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data?.currentHand.dealer.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              if (index == 0) {
                                return Container(
                                    child: Image.asset(
                                        'assets/Cards/card_back.png',
                                        height: 50,
                                        width: 250
                                    )
                                );
                              }
                              return Container(
                                  child: Image.asset(
                                    'assets/Cards/${snapshot.data?.currentHand.dealer[index]}.png',
                                    height: 25,
                                    width: 150,
                                  )
                              );
                            }
                        ),
                      ),
                    ),
                    // Positioned(
                    //   left: firstDealerCardX,
                    //   top: firstDealerCardY,
                    //   child: Image.asset(backOfCard),
                    //   height: 100,
                    // ),
                    // Positioned(
                    //   left: firstDealerCardX + 20,
                    //   top: firstDealerCardY,
                    //   child: Image.asset(playingCards[AICard2]),
                    //   height: 100,
                    // ),
                    // Positioned(
                    //   left: secondDealerCardX + 40,
                    //   top: secondDealerCardY,
                    //   child: Image.asset(playingCards[AICard3]),
                    //   height: 100,
                    // ),
                    // Positioned(
                    //   left: thirdDealerCardX + 60,
                    //   top: thirdDealerCardY,
                    //   child: Image.asset(playingCards[AICard4]),
                    //   height: 100,
                    // ),
                    // Positioned(
                    //   left: fourthDealerCardX + 80,
                    //   top: fourthDealerCardY,
                    //   //  child: Visibility(
                    //   child: Image.asset(playingCards[AICard5]),
                    //   // replacement: Container(),
                    //   // visible: _fourthDealerCardVisibility,
                    //   //   ),
                    //   height: 100,
                    // ),


//BUTTON IF HIT
                    Positioned(
                      right: 250,
                      bottom: 75,
                      child: Container(
                        width: 100,
                        height: 50,

                        child: ElevatedButton(
                            // onPressed: onHit,
                            onPressed: () {
                              _api.userHit(_table.id.toString(), '0');
                            },
                            child: Text("Hit")
                        ),
                      ),
                    ),
                    //BUTTON IF STAY
                    Positioned(
                      left: 250,
                      bottom: 75,
                      child: Container(
                        width: 100,
                        height: 50,
                        child: RaisedButton(onPressed: onStay,
                            child: Text("Stay")
                        ),
                      ),
                    ),
                    //BUTTON IF DEAL
                    Positioned(
                      left: dealerButtonX,
                      top: dealerButtonY,
                      child: Container(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                            // onPressed: onDeal,
                            onPressed: () {
                              _api.startGame(_table.id.toString());
                            },
                            child: const Text('Deal')
                        ),
                      ),
                    ),

                    //button to redeal
                    Positioned(
                      left: playAgainButtonX,
                      top: playAgainButtonY,
                      child: Container(
                        width: 150,
                        height: 50,
                        child: RaisedButton(onPressed: restartGame,
                            child: Text("Press to play again ")
                        ),
                      ),
                    ),
//BETTING
                    //INPUT BETTING BOX

                    if (_state.playerSubject.value.id == _table.players[_table.currentHand.status].id) Positioned(
                      left: 300,
                      top: 200,
                      child: Container(
                        width: 200,
                        height: 50,

                        child: TextField(

                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),

                            hintText: 'Enter a bet',

                          ),

                          onChanged: (input) {
                            _api.placeBet(_table.id.toString(), '0', int.parse(input));
                            // setState(() {
                            //   startClick = true;
                            //   bet = double.parse(input);
                            // });
                          },
                        ),
                      ),
                    ),
                    //DISPLAYING WHAT HAS BEEN BET
                    if (_state.playerSubject.value.id == _table.players[_table.currentHand.status].id) Positioned(
                      left: 300,
                      top: 250,
                      child: Text('${bet}'),
                    ),

                    // Idea to make the restart screen go when your coins drop below zero
                    Positioned(
                      left: restartX,
                      top: restartY,
                      child: Container(
                        width: 150,
                        height: 50,

                        child: RaisedButton(
                          child: Text("Play again"),
                          onPressed: () async {
                            Restart.restartApp();
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      left: restartX,
                      top: restartY + 50,
                      child: Text('You are lost and are out of coins! Would you like to play again'),
                    ),

                    Center(
                      child: Container(
                        height: titleScreenH,
                        width: titleScreenH,
                        color: Colors.black,

                        // child: Text('Welcome to Black Jack',
                        // style: TextStyle(fontSize: 50),
                        // ),
                      ),
                    ),


                    Positioned(
                      top: playButtonY,
                      right: playButtonX,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            titleScreenH = 0;
                            playButtonX = 1000;
                            playButtonY = 1000;

                          });
                        },
                        child: Text("Play"),


                      ),
                    ),


                  ], //stay inside these when creating new buttons and images
                );
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
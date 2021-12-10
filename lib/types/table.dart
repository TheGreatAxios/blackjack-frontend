import 'player.dart';

class Dealer {
  List<String> cards = [];
  bool isActive = false;
  bool hasBlackjack;
  bool hasBusted;
  int currentHandValue;

  Dealer({
    required this.cards,
    required this.isActive,
    required this.hasBlackjack,
    required this.hasBusted,
    required this.currentHandValue
  });

  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
      cards: List<String>.from(json['cards']),
      isActive: json['isActive'],
      hasBlackjack: json['hasBlackjack'],
      hasBusted: json['hasBusted'],
      currentHandValue: json['currentHandValue']
    );
  }
}

class GameTable {
  late Player playerOne;
  late Player playerTwo;
  late Dealer dealer;
  late bool isGameActive;
  late bool isPlayerOneTurn;
  late bool isPlayerTwoTurn;
  late bool isDealerTurn;
  late bool isGameOver;
  late bool isDealing;
  late bool readyToDeal;
  late List<String> messages;

  GameTable({
    required this.playerOne,
    required this.playerTwo,
    required this.dealer,
    required this.isGameActive,
    required this.isPlayerOneTurn,
    required this.isPlayerTwoTurn,
    required this.isDealerTurn,
    required this.isGameOver,
    required this.isDealing,
    required this.readyToDeal,
    required this.messages,
  });

  factory GameTable.fromJson(Map<String, dynamic> json) {

    // List _jsonPlayers = json['players'];

    return GameTable(
        playerOne: Player.fromJson(json['playerOne']), // Player.fromJson
        playerTwo: Player.fromJson(json['playerTwo']),// Player.fromJson
        dealer: Dealer.fromJson(json['dealer']),
        isGameActive: json['isGameActive'],
        isPlayerOneTurn: json['isPlayerOneTurn'],
        isPlayerTwoTurn: json['isPlayerTwoTurn'],
        isDealerTurn: json['isDealerTurn'],
        isGameOver: json['isGameOver'],
        isDealing: json['isDealing'],
        readyToDeal: json['readyToDeal'],
        messages: List<String>.from(json['messages']),
    );
  }
}

// class IHand {
//   List<String> dealer = []; // Dealer Cards
//   List<IPlayerInGame> players = [];
//   int status;
//   String result;
//   int dealerHandValue;
//
//   IHand({
//     required this.dealer,
//     required this.players,
//     required this.status,
//     required this.result,
//     required this.dealerHandValue
//   });
//
//   factory IHand.fromJson(Map<String, dynamic> json) {
//
//     List _playersJson = json['players'];
//
//     return IHand(
//       dealer: List<String>.from(json['dealer']),
//       players: _playersJson.map((dynamic  p) => IPlayerInGame.fromJson(p)).toList(),
//       status: json['status'],
//       result: json['result'],
//       dealerHandValue: json['dealerHandValue']
//     );
//   }
// }

// class IPlayerInGame {
//   late int playerId;
//   late bool inGame;
//   late List<String> cards;
//   late List<int> bets;
//   late List<String> actions; // HIT | STAND | DOUBLE
//   late int handValue;
//
//   IPlayerInGame({
//     required this.playerId,
//     required this.inGame,
//     required this.cards,
//     required this.bets,
//     required this.actions,
//     required this.handValue
//   });
//
//
//   factory IPlayerInGame.fromJson(Map<String, dynamic> json) {
//     return IPlayerInGame(
//         playerId: int.parse(json['playerId']),
//         inGame: json['inGame'],
//         cards: json['cards'] != null && json['cards'].length > 0 ? List.castFrom(json['cards'] as List) : [],
//         bets: json['bets'] != null && json['bets'].length > 0 ? List.castFrom(json['bets'] as List) : [],
//         actions: json['actions'] != null && json['actions'].length > 0 ? List.castFrom(json['actions'] as List) : [],
//         handValue: json['handValue']
//     );
//   }
// }
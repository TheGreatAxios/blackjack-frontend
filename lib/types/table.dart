import 'player.dart';

class GameTable {
  final int id;
  late List<Player> players;
  late int timer;
  late String gameStatus;
  late IHand currentHand = IHand(dealer: [], players: [], status: 0);

  GameTable({
    required this.id,
    required this.players,
    required this.currentHand,
    required this.timer
  });

  factory GameTable.fromJson(Map<String, dynamic> json) {

    List _jsonPlayers = json['players'];

    return GameTable(
      id: json['id'],
      players: _jsonPlayers.map((dynamic p) => Player.fromJson(p)).toList(),
      currentHand: json['currentHand'] != null ? IHand.fromJson(json['currentHand']) : IHand(dealer: [], players: [], status: 0),
      timer: json['timer'] ?? 0
    );
  }
}

class IHand {
  List<String> dealer = []; // Dealer Cards
  List<IPlayerInGame> players = [];
  int status = 0;

  IHand({
    required this.dealer,
    required this.players,
    required this.status
  });

  factory IHand.fromJson(Map<String, dynamic> json) {

    List _playersJson = json['players'];

    return IHand(
      dealer: List<String>.from(json['dealer']),
      players: _playersJson.map((dynamic  p) => IPlayerInGame.fromJson(p)).toList(),
      status: json['status']
    );
  }
}

class IPlayerInGame {
  late int playerId;
  late bool inGame;
  late List<String> cards;
  late List<int> bets;
  late List<String> actions; // HIT | STAND | DOUBLE

  IPlayerInGame({
    required this.playerId,
    required this.inGame,
    required this.cards,
    required this.bets,
    required this.actions,
  });


  factory IPlayerInGame.fromJson(Map<String, dynamic> json) {
    return IPlayerInGame(
        playerId: int.parse(json['playerId']),
        inGame: json['inGame'],
        cards: json['cards'] != null && json['cards'].length > 0 ? List.castFrom(json['cards'] as List) : [],
        bets: json['bets'] != null && json['bets'].length > 0 ? List.castFrom(json['bets'] as List) : [],
        actions: json['actions'] != null && json['actions'].length > 0 ? List.castFrom(json['actions'] as List) : [],
    );
  }
}
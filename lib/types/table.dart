import 'player.dart';

class GameTable {
  final int id;
  late List<Player> players;
  late int timer;
  late String gameStatus;
  late IHand currentHand;

  GameTable({
    required this.id,
    required this.players
  });

  factory GameTable.fromJson(Map<String, dynamic> json) {

    List _jsonPlayers = json['players'];

    return GameTable(
      id: json['id'],
      players: _jsonPlayers.map((dynamic p) => Player.fromJson(p)).toList(),
    );
  }
}

class IHand {
  late List<String> dealer; // Dealer Cards
  late List<IPlayerInGame> players;
  late int status;
}

class IPlayerInGame {
  late int playerId;
  late bool inGame;
  late List<String> cards;
  late List<int> bets;
  late List<String> actions; // HIT | STAND | DOUBLe
}
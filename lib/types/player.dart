class Player {
  String name;
  int balance;
  int currentBet;
  List<String> currentHand;
  bool isActive;
  bool isReady;
  bool? hasWon;
  bool? hasBusted;
  bool hasJoined;
  bool? hasBlackjack;
  bool? hasPushed;
  int currentHandValue;

  Player({
    required this.name,
    required this.balance,
    required this.currentBet,
    required this.currentHand,
    required this.isActive,
    required this.isReady,
    required this.hasWon,
    required this.hasBusted,
    required this.hasJoined,
    required this.hasBlackjack,
    required this.hasPushed,
    required this.currentHandValue
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    print("JSON: ${json.toString()}");
    return Player(
        name: json['name'],
        balance: json['balance'],
        currentBet: json['currentBet'],
        currentHand: List<String>.from(json['currentHand'] as List),
        isActive: json['isActive'],
        isReady: json['isReady'],
        hasWon: json['hasWon'],
        hasBusted: json['hasBusted'],
        hasJoined: json['hasJoined'],
        hasBlackjack: json['hasBlackjack'],
        hasPushed: json['hasPushed'],
        currentHandValue: json['currentHandValue']
    );
  }
}
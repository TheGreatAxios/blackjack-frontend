class Player {
  final int id;
  final String name;
  late int balance;

  Player({
    required this.id,
    required this.name,
    required this.balance
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: int.parse(json['id']),
      name: json['name'],
      balance: json['balance']
    );
  }
}
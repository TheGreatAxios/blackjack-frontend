import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart' show WebSocketChannel;

class Api {
  Api._();
  static final Api _singleton = Api._();
  static Api get instance => _singleton;
  static const baseUrl = 'http://localhost:8080';
  static const wsUrl = 'ws://localhost:8080';

  final WebSocketChannel ws = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));
  final BehaviorSubject wsSubject = BehaviorSubject();
  Stream<dynamic> get wsStream => wsSubject.stream;

  void addSocketStream() {
    wsSubject.addStream(ws.stream);
  }

  void createUser(String _userName) {
    ws.sink.add(jsonEncode({"action": "JOIN", "name": _userName}));
  }

  // void connectUser(String _id, String _playerId) {
  //   ws.sink.add(jsonEncode({"action": "CONNECT", "roomId": _id, "data": {"playerId": _playerId}}));
  // }
  //
  // void startGame(String _id) {
  //   ws.sink.add(jsonEncode({ "action": "START_GAME", "roomId": _id }));
  // }
  //
  // void placeBet(String _id, String _playerId, int _bet) {
  //   ws.sink.add(jsonEncode({ "action": "USER_BET", "roomId": _id, "playerId": _playerId, "betAmount": _bet }));
  // }
  //
  // void userHit(String _id, String _playerId) {
  //   ws.sink.add(jsonEncode({"action": "USER_HIT", "roomId": _id, "playerId": _playerId }));
  // }
  // void userStay(String _id, String _playerId) {
  //   ws.sink.add(jsonEncode({"action": "USER_STAY", "roomId": _id, "playerId": _playerId }));
  // }
}
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
    ws.sink.add(jsonEncode({"action": "NEW_USER", "roomId": "0", "userName": _userName}));
  }

  void connectUser(String _id, String _playerId) {
    ws.sink.add(jsonEncode({"action": "CONNECT", "roomId": _id, "data": {"playerId": _playerId}}));
  }
}
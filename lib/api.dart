import 'dart:collection';
import 'dart:convert';
// import 'dart:html';

import 'package:http/http.dart' as Http;
import 'package:web_socket_channel/io.dart';
// import 'dart:html' show Client, WebSocket;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class Api {
  Api._();
  static final Api _singleton = Api._();
  static Api get instance => _singleton;
  static const baseUrl = 'http://localhost:8080';
  static const wsUrl = 'ws://localhost:8080';

  // final Client _client = Client();
  final WebSocketChannel ws = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));

  WebSocketChannel getWebSocket() {
    return ws;
  }

  // Future<String> getRequest(String path) async {
  //   try {
  //     Response res = await _client.get(Uri.parse('http://localhost:8080'));
  //     return res.body;
  //   } catch (err) {
  //     print("Err: ${err.toString()}");
  //     throw Exception("Error");
  //   }
  // }

  void createUser(String _userName) {
    ws.sink.add(jsonEncode({"action": "NEW_USER", "roomId": "0", "userName": _userName}));
  }

  void connectUser(String _id, String _playerId) {
    ws.sink.add(jsonEncode({"action": "CONNECT", "roomId": _id, "data": {"playerId": _playerId}}));
  }

  // void listen() {
  //   ws.
  // }
}
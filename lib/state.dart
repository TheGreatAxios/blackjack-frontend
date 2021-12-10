import 'package:rxdart/rxdart.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_one/api.dart';
import 'package:test_one/types/player.dart';
import 'package:test_one/types/table.dart';

class GameState {

  final Api _api = Api.instance;

  GameState._();
  static final GameState _singleton = GameState._();
  static GameState get instance => _singleton;

  final BehaviorSubject<GameTable> tableSubject = BehaviorSubject<GameTable>();
  final BehaviorSubject<String> playerName = BehaviorSubject<String>();

  Stream<GameTable> get tableStream => tableSubject.stream;



}
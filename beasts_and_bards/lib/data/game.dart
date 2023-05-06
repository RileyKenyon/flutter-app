import 'package:beasts_and_bards/data/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  Game(
      {required this.name,
      required this.players,
      required this.gameId,
      this.dm = "",
      this.active = false});
  final String name;
  final List<Friend> players;
  final String gameId;
  final String dm;
  final bool active;

  factory Game.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Game(
      name: data?['name'],
      players: data?['players'] is Iterable
          ? Map.from(data?['players']) as List<Friend>
          : List<Friend>.empty(growable: true),
      gameId: data?['gameId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "gameId": gameId,
      "dm": dm,
      "name": name,
      "active": active,
      "players": {}
    };
  }
}

import 'package:beasts_and_bards/data/friend.dart';

class Game {
  Game(
      {required this.name,
      required this.players,
      this.dm = "",
      this.active = false});
  final String name;
  final List<Friend> players;
  final String dm;
  final bool active;
}

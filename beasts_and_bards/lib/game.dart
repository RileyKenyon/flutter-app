import 'package:beasts_and_bards/friend.dart';

class Game {
  Game({required this.name, required this.dm, required this.players});
  final String name;
  final String dm;
  final List<Friend> players;
}

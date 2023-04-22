import 'package:beasts_and_bards/friend.dart';

class Game {
  Game({required this.name, required this.players});
  final String name;
  final List<Friend> players;
}

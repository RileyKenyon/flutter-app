class Abilities {
  Abilities({
    required this.charisma,
    required this.constitution,
    required this.dexterity,
    required this.intelligence,
    required this.strength,
    required this.wisdom,
  });
  final int charisma;
  final int constitution;
  final int dexterity;
  final int intelligence;
  final int strength;
  final int wisdom;
}

class Character {
  Character({
    required this.name,
    required this.race,
    required this.abilities,
    required this.gameId,
    required this.uuid,
    this.active = false,
  });
  final String name;
  final String race;
  final Abilities abilities;
  final String gameId;
  final String uuid;
  final bool active;
}

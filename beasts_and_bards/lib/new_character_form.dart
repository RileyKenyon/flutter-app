import 'package:beasts_and_bards/app_state.dart';
import 'package:beasts_and_bards/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:uuid/uuid.dart';
import 'src/dio_widgets.dart';
import 'data/character.dart';

class NewCharacterPage extends StatefulWidget {
  const NewCharacterPage({super.key, required this.appState});
  final ApplicationState appState;

  @override
  State<NewCharacterPage> createState() => _NewCharacterPage();

  Set<Future<void>> submitCharacter(Character c) =>
      {appState.addCharacterToDatabase(c)};

  // Set<Future<void>> addCharacterToProfile(Character c) => {
  //       appState.addCharacterToProfile(c)
  //     };
}

class _NewCharacterPage extends State<NewCharacterPage> {
  final nameController = TextEditingController();
  final raceController = TextEditingController();
  final gameController = TextEditingController();
  final abilityControllers = List<TextEditingController>.generate(
      6, (int n) => TextEditingController(),
      growable: false);
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(color: Colors.red),
      //         child: Image(image: AssetImage('assets/d20.png')),
      //       ),
      //       ListTile(
      //         title: const Text('Go Home'),
      //         onTap: () => (context.go('/')),
      //       ),
      //       ListTile(
      //         title: const Text('Profile'),
      //         onTap: () => (context.go('/profile')),
      //       )
      //     ],
      //   ),
      // ),
      appBar: AppBar(title: const Text("CREATE A NEW CHARACTER")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text("Create a new Character!",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              // @todo break this out to a separate widget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    icon: Icon(MdiIcons.gamepad),
                    border: OutlineInputBorder(),
                    hintText: "Select Game",
                    labelText: "Select Game",
                  ),
                  items: const [
                    DropdownMenuItem(
                      child: Text('Test Game'),
                      value: "Test",
                    ),
                    DropdownMenuItem(
                      child: Text('Test Game 2'),
                      value: "Test2",
                    ),
                  ],
                  onChanged: (dynamic) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(MdiIcons.head),
                      border: OutlineInputBorder(),
                      hintText: "Character Name",
                      labelText: "Character Name"),
                  controller: nameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(MdiIcons.tree),
                      border: OutlineInputBorder(),
                      hintText: "Race Name",
                      labelText: "Race Name"),
                  controller: raceController,
                ),
              ),
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              //   // decoration: const BoxDecoration(
              //   //   border: Border(bottom: BorderSide(color: Colors.black)),
              //   // ),
              //   child: Text(
              //     "Abilities",
              //     style: Theme.of(context).textTheme.titleLarge,
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        AbilityWidget(
                            "Charisma",
                            const Icon(MdiIcons.starShooting),
                            abilityControllers[0]),
                        AbilityWidget(
                          "Constitution",
                          const Icon(MdiIcons.heart),
                          abilityControllers[1],
                          key: const Key("Constitution"),
                        ),
                        AbilityWidget("Dexterity", const Icon(MdiIcons.runFast),
                            abilityControllers[2]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        AbilityWidget("Intelligence",
                            const Icon(MdiIcons.brain), abilityControllers[3]),
                        AbilityWidget("Strength", const Icon(MdiIcons.armFlex),
                            abilityControllers[4]),
                        AbilityWidget("Wisdom", const Icon(MdiIcons.library),
                            abilityControllers[5]),
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Uuid uuid = const Uuid();
                  Character character = Character(
                      name: nameController.text,
                      race: raceController.text,
                      abilities: Abilities(
                          charisma: int.parse(abilityControllers[0].text),
                          constitution: int.parse(abilityControllers[1].text),
                          dexterity: int.parse(abilityControllers[2].text),
                          intelligence: int.parse(abilityControllers[3].text),
                          strength: int.parse(abilityControllers[4].text),
                          wisdom: int.parse(abilityControllers[5].text)),
                      gameId: 'Game ID',
                      uuid: uuid.v1());
                  // context.go('/game-detail');
                  widget.submitCharacter(character);
                  context.pop();
                  // widget.addCharacterToProfile(character);
                },
                child: const Text("Submit Character"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

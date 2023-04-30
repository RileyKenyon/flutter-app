import 'package:beasts_and_bards/app_state.dart';
import 'package:beasts_and_bards/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'src/dio_widgets.dart';
import 'data/character.dart';

class NewCharacterPage extends StatefulWidget {
  const NewCharacterPage({super.key, required this.appState});
  final ApplicationState appState;

  @override
  State<NewCharacterPage> createState() => _NewCharacterPage();

  Set<Future<void>> submitCharacter() => {
        appState.addCharacterToDatabase(Character(
            name: "bob",
            race: "elf",
            abilities: Abilities(
                charisma: 1,
                constitution: 1,
                dexterity: 2,
                intelligence: 4,
                strength: 5,
                wisdom: 10),
            gameId: "Generic Game",
            uuid: "jjkldsfj-dsfasdfkl2-324e"))
      };
}

class _NewCharacterPage extends State<NewCharacterPage> {
  final nameController = TextEditingController();
  final raceController = TextEditingController();
  final gameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Character newCharacter;
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                // decoration: const BoxDecoration(
                //   border: Border(bottom: BorderSide(color: Colors.black)),
                // ),
                child: Text(
                  "Abilities",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            icon: Icon(MdiIcons.brain),
                            border: OutlineInputBorder(),
                            labelText: "Dexterity"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Enter your value"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Text("Push button to submit character"),
              ElevatedButton(
                  onPressed: () => widget.submitCharacter(),
                  child: const Icon(Icons.abc)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:beasts_and_bards/friend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_state.dart';
import 'src/widgets.dart';
import 'game.dart';

class CreateGameForm extends StatefulWidget {
  const CreateGameForm({super.key, required this.appState});
  final ApplicationState appState;

  @override
  State<CreateGameForm> createState() => _CreateGameFormState();

  void submitGame(String gameName) => {appState.addMessageToDatabase(gameName)};
}

class _CreateGameFormState extends State<CreateGameForm> {
  final textController = TextEditingController();
  final playerTextController = TextEditingController();
  var searchFriendList = <Friend>[];
  var partyList = <Friend>[];

  @override
  void dispose() {
    textController.dispose();
    playerTextController.dispose();
    super.dispose();
  }

  void filterSearchResults(String query) {
    setState(() {
      searchFriendList = widget.appState.friendsList
          .where((item) =>
              item.name.toLowerCase().contains(query.toLowerCase()) &&
              !partyList.contains(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("START A NEW ADVENTURE")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text('Create a New Game!',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.shield),
                  border: OutlineInputBorder(),
                  hintText: "Party Title",
                  labelText: "Party Title"),
              controller: textController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Text("Players: "),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                  hintText: "Names",
                ),
                controller: playerTextController,
                onChanged: (value) {
                  filterSearchResults(value);
                },
              ),
            ),
            Visibility(
              visible: widget.appState.friendsList.isNotEmpty,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  itemCount: searchFriendList.length,
                  prototypeItem: ListTile(
                    title: Text(searchFriendList.isNotEmpty
                        ? searchFriendList.first.name
                        : "None"),
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(searchFriendList[index].name),
                      onTap: () {
                        partyList.add(searchFriendList[index]);
                      },
                    );
                  },
                ),
              ),
            ),
            OutlinedButton(
                child:
                    const IconAndDetail(Icons.insert_emoticon_sharp, "Submit"),
                onPressed: () {
                  final String? username =
                      FirebaseAuth.instance.currentUser?.displayName;
                  if (username != null) {
                    widget.appState.addGameToDatabase(
                      Game(
                          name: textController.text,
                          players: partyList,
                          dm: username,
                          active: false),
                    );
                    context.pushReplacement('/dashboard');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
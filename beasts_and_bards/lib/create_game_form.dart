import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_state.dart';

class CreateGameForm extends StatefulWidget {
  const CreateGameForm({super.key, required this.appState});
  final ApplicationState appState;

  @override
  State<CreateGameForm> createState() => _CreateGameFormState();

  void submitGame(String gameName) => {appState.addMessageToDatabase(gameName)};
}

class _CreateGameFormState extends State<CreateGameForm> {
  final textController = TextEditingController();
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("START A NEW ADVENTURE")),
      body: ListView(children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text('Create a New Game!',
                style: Theme.of(context).textTheme.titleLarge)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.shield),
                border: OutlineInputBorder(),
                hintText: "Party Title",
                labelText: "Party Title"),
            controller: textController,
          ),
        ),
        OutlinedButton(
            child: const Text("Submit"),
            onPressed: () => {
                  widget.appState.addMessageToDatabase(textController.text),
                  context.pushReplacement('/dashboard'),
                })
      ]),
    );
  }
}

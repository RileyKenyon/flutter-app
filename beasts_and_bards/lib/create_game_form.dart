import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_state.dart';
import 'src/widgets.dart';

class CreateGameForm extends StatefulWidget {
  const CreateGameForm({super.key, required this.appState});
  final ApplicationState appState;

  @override
  State<CreateGameForm> createState() => _CreateGameFormState();

  void submitGame(String gameName) => {appState.addMessageToDatabase(gameName)};
}

class _CreateGameFormState extends State<CreateGameForm> {
  final textController = TextEditingController();
  final List<String> items =
      List<String>.generate(100, (index) => 'Item $index');

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("START A NEW ADVENTURE")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text('Create a New Game!',
                style: Theme.of(context).textTheme.titleLarge),
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
              child: Text("Players:",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(hintText: "Names"),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                itemCount: items.length,
                prototypeItem: ListTile(
                  title: Text(items.first),
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                  );
                },
              ),
            ),
            OutlinedButton(
                child:
                    const IconAndDetail(Icons.insert_emoticon_sharp, "Submit"),
                onPressed: () => {
                      widget.appState.addMessageToDatabase(textController.text),
                      context.pushReplacement('/dashboard'),
                    }),
          ],
        ),
      ),
    );
  }
}

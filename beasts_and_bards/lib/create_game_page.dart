import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'src/authentication.dart';
import 'src/widgets.dart';
import 'yes_no_selection.dart';

class CreateGamePage extends StatelessWidget {
  CreateGamePage({super.key, required this.appState});

  final ApplicationState appState;

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
              onSaved: (String? value) {}),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Party Title")),
        ),
        OutlinedButton(
            child: const Text("Submit"),
            onPressed: () => {
                  context.go('/dashboard'),
                  appState.addMessageToDatabase("testing")
                })
      ]),
    );
  }
}

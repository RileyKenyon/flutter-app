import 'package:beasts_and_bards/friend.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'src/authentication.dart';
import 'src/widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.appState});
  final ApplicationState appState;

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.red),
                child: Image(image: AssetImage('assets/d20.png')),
              ),
              ListTile(
                title: const Text('Go Home'),
                onTap: () => (context.go('/')),
              )
            ],
          ),
        ),
        appBar: AppBar(title: const Text("Dashboard")),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child:
                Text('Welcome!', style: Theme.of(context).textTheme.titleLarge),
          ),
          Visibility(
            visible: widget.appState.gameList.isNotEmpty,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                itemCount: widget.appState.gameList.length,
                prototypeItem: ListTile(
                  title: Text(widget.appState.gameList.isNotEmpty
                      ? widget.appState.gameList.first.name
                      : "None"),
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.appState.gameList[index].name),
                    onTap: () => {context.push('/game-detail')},
                  );
                },
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: () => context.push('/create-game'),
          child: const Icon(Icons.add),
        ));
  }
}

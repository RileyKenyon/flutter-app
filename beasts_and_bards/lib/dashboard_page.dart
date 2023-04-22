import 'package:beasts_and_bards/friend.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'src/authentication.dart';
import 'src/widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.friends});

  final List<Friend> friends;

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

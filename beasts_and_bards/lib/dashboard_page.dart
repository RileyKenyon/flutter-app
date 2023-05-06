import 'dart:ffi';

import 'package:beasts_and_bards/data/friend.dart';
import 'package:beasts_and_bards/data/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  final Stream<QuerySnapshot> _dashboardStream = FirebaseFirestore.instance
      .collection('games')
      // .withConverter(
      //     fromFirestore: Game.fromFirestore,
      //     toFirestore: (Game game, options) => game.toFirestore())
      .snapshots();

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
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () => (context.go('/profile')),
              )
            ],
          ),
        ),
        appBar: AppBar(title: const Text("Dashboard")),
        body: StreamBuilder<QuerySnapshot>(
          stream: _dashboardStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return const Text('Oops something went wrong');
            }

            if (snapshot.data == null) {
              return const Text('Create a game to get started!');
            }
            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                        title: Text(data['name'] ?? "No name"),
                        subtitle: Text(data['dm'] ?? "No Dungeon Master"));
                  })
                  .toList()
                  .cast(),
            );
          },
        ),
        // ListView(children: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        //     child:
        //         Text('Welcome!', style: Theme.of(context).textTheme.titleLarge),
        //   ),
        //   Visibility(
        //     visible: widget.appState.gameList.isNotEmpty,
        //     child: ConstrainedBox(
        //       constraints: const BoxConstraints(maxHeight: 300),
        //       child: ListView.builder(
        //         itemCount: widget.appState.gameList.length,
        //         prototypeItem: DashboardListItem(
        //           game: Game(name: "None", players: [], gameId: ""),
        //           onTap: () {},
        //         ),
        //         itemBuilder: (context, index) {
        //           return DashboardListItem(
        //               game: widget.appState.gameList[index],
        //               onTap: () => {
        //                     context.push('/game-detail',
        //                         extra: widget.appState.gameList[index])
        //                   });
        //         },
        //       ),
        //     ),
        //   ),
        // ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: () => context.push('/create-game'),
          child: const Icon(Icons.add),
        ));
  }
}

import 'package:beasts_and_bards/app_state.dart';
import 'package:beasts_and_bards/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'src/dio_widgets.dart';

class NewCharacterPage extends StatefulWidget {
  const NewCharacterPage({super.key, required this.appState});
  final ApplicationState appState;

  @override
  State<NewCharacterPage> createState() => _NewCharacterPage();
}

class _NewCharacterPage extends State<NewCharacterPage> {
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
      appBar: AppBar(title: const Text("Create a New Character")),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child:
              Text('Welcome!', style: Theme.of(context).textTheme.titleLarge),
        ),
      ]),
    );
  }
}

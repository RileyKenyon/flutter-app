import 'package:beasts_and_bards/app_state.dart';
import 'package:beasts_and_bards/data/game.dart';
import 'package:beasts_and_bards/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'src/dio_widgets.dart';

class GameDetailPage extends StatefulWidget {
  const GameDetailPage({super.key, required this.appState, required this.game});
  final ApplicationState appState;
  final Game game;
  @override
  State<GameDetailPage> createState() => _GameDetailPage();
}

class _GameDetailPage extends State<GameDetailPage> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  int _selectedIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.appState.activeGameId = widget.game.gameId;
    final List<Widget> widgets = <Widget>[
      CharacterWidget(game: widget.game),
      const Text('Inventory'),
      const DndManager(),
      const MapWidget(title: 'Map')
    ];
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    const bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Character"),
      BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag), label: "Inventory"),
      BottomNavigationBarItem(icon: Icon(Icons.book), label: "Monsters"),
      BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
    ];
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
              title: const Text('Dashboard'),
              onTap: () => (context.go('/dashboard')),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () => (context.go('/profile')),
            )
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Quest')),
      body: Center(
        child: widgets.elementAt(_selectedIndex),
      ),
      floatingActionButton: Visibility(
        visible: _selectedIndex == 0,
        child: FloatingActionButton(
          onPressed: () => (context.push('/create-new-character')),
          backgroundColor: colorScheme.primary,
          child: const Icon(MdiIcons.sword),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorScheme.primary,
        selectedItemColor: colorScheme.onPrimary,
        items: bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

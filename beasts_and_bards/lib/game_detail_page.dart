import 'package:beasts_and_bards/app_state.dart';
import 'package:beasts_and_bards/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_manager/nfc_manager.dart';

class GameDetailPage extends StatefulWidget {
  const GameDetailPage({super.key, required this.appState});
  final ApplicationState appState;
  @override
  State<GameDetailPage> createState() => _GameDetailPage();
}

class _GameDetailPage extends State<GameDetailPage> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  int _selectedIndex = 0;

  static const List<Widget> _widgets = <Widget>[
    Text('Character'),
    Text('Inventory'),
    Text('Monters'),
    MapWidget(title: 'Map')
  ];

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
        child: _widgets.elementAt(_selectedIndex),
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

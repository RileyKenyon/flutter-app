import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  String username = "";
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        username = ('User is currently signed out!');
      } else {
        username = ('User is signed in!');
      }
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('images/title.gif'),
            Text(
              'Welcome! $username',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            ElevatedButton(
                onPressed: getUsername, child: Text("Update: $username")),
            const SignOutButton(),
          ],
        ),
      ),
    );
  }

  void getUsername() {
    username = "abcd";
    if (FirebaseAuth.instance.currentUser != null) {
      if (FirebaseAuth.instance.currentUser!.displayName != null) {
        username = FirebaseAuth.instance.currentUser!.displayName!;
      }
    }
  }
}

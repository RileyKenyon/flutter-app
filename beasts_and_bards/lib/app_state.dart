// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'data/friend.dart';
import 'data/game.dart';
import 'firebase_options.dart';
import 'dart:io';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  bool _emailVerified = false;

  bool get emailVerified => _emailVerified;

  StreamSubscription<QuerySnapshot>? _databaseSubscription;
  StreamSubscription<QuerySnapshot>? _friendsListSubscription;
  List<Friend> _friendsList = [];
  List<Friend> get friendsList => _friendsList;

  // Add game list for user
  List<Game> _gameList = [];
  List<Game> get gameList => _gameList;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    // }
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    if (loggedIn && FirebaseAuth.instance.currentUser != null) {
      _friendsListSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('friendslist')
          .snapshots()
          .listen((snapshot) {
        _friendsList = [];
        for (final friend in snapshot.docs) {
          if (friend.data()['name'] != null) {
            _friendsList.add(
              Friend(
                name: friend.data()['name'] as String,
                message: "",
              ),
            );
          }
        }
        notifyListeners();
      });
      _databaseSubscription = FirebaseFirestore.instance
          .collection('games')
          .snapshots()
          .listen((snapshot) {
        _gameList = [];
        for (final doc in snapshot.docs) {
          List<Friend> players = [];
          for (final f in doc.data()['players']) {
            players.add(Friend(name: f, message: ""));
          }
          _gameList.add(
              Game(name: "abcd", players: players, dm: "doc", active: false));
        }
        stdout.writeln('Number of games ${snapshot.docs.length}');
        notifyListeners();
      });
    }

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _emailVerified = user.emailVerified;
        _friendsListSubscription = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('friendslist')
            .snapshots()
            .listen((snapshot) {
          _friendsList = [];
          for (final friend in snapshot.docs) {
            if (friend.data()['name'] != null) {
              _friendsList.add(
                Friend(
                  name: friend.data()['name'] as String,
                  message: "",
                ),
              );
            }
          }
          notifyListeners();
        });
        _databaseSubscription = FirebaseFirestore.instance
            .collection('games')
            .snapshots()
            .listen((snapshot) {
          _gameList = [];
          for (final doc in snapshot.docs) {
            List<Friend> players = [];
            if (doc.data()['players'] != null) {
              List<String> playerNames = List.from(doc.data()['players']);
              for (final f in playerNames) {
                players.add(Friend(name: f, message: ""));
              }
            }
            _gameList.add(
              Game(
                name: doc.data()['text'],
                players: players,
                dm: doc.data()['name'],
                active: false,
              ),
            );
          }
          stdout.writeln('Number of games ${snapshot.docs.length}');
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _emailVerified = false;
        _databaseSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<void> refreshLoggedInUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return;
    }

    await currentUser.reload();
  }

  Future<DocumentReference> addMessageToDatabase(String message) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('games').add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  Future<DocumentReference> addGameToDatabase(Game newgame) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    List<String> playerNames = [];
    for (final player in newgame.players) {
      playerNames.add(player.name);
    }

    return FirebaseFirestore.instance.collection('games').add(<String, dynamic>{
      'text': newgame.name,
      'players': playerNames,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  Future<DocumentReference> addCharacterToPlayer(Character character) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('games').add(<String, dynamic>{
      'text': newgame.name,
      'players': playerNames,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  

}

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        fontFamily: 'Iceberg',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.black,
        ),
      ),
      home: const RandomWords(),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        leading: IconButton(
          icon: const Icon(Icons.list),
          onPressed: _pushSaved,
          tooltip: 'Saved Suggestions',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: Center(
          child: Image.asset(
        "images/title.gif",
        height: 250.0,
        width: 250.0,
      )),
      // body: ListView.builder(
      //   padding: const EdgeInsets.all(16.0),
      //   itemBuilder: (context, i) {
      //     if (i.isOdd) return const Divider();

      //     final index = i ~/ 2;
      //     if (index >= _suggestions.length) {
      //       _suggestions.addAll(generateWordPairs().take(10));
      //     }

      //     final alreadySaved = _saved.contains(_suggestions[index]);

      //     return ListTile(
      //       title: Text(
      //         _suggestions[index].asPascalCase,
      //         style: _biggerFont,
      //       ),
      //       trailing: Icon(
      //         alreadySaved ? Icons.favorite : Icons.favorite_border,
      //         color: alreadySaved ? Colors.red : null,
      //         semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
      //       ),
      //       onTap: () {
      //         setState(() {
      //           if (alreadySaved) {
      //             _saved.remove(_suggestions[index]);
      //           } else {
      //             _saved.add(_suggestions[index]);
      //           }
      //         });
      //       },
      //     );
      //   },
      // ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

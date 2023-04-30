// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ffi';

import 'package:beasts_and_bards/app_state.dart';
import 'package:flutter/material.dart';
import 'package:beasts_and_bards/data/game.dart';
import 'package:beasts_and_bards/src/dio_widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart';

class Header extends StatelessWidget {
  const Header(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {super.key});
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail, {super.key});
  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, super.key});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        // style:
        //     OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
        onPressed: onPressed,
        child: child,
      );
}

class DashboardListItem extends StatelessWidget {
  const DashboardListItem({required this.game, required this.onTap, super.key});
  final Game game;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: ListTile(
          leading: game.active
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.do_not_disturb,
                  color: Colors.red,
                ),
          title: Text(game.name),
          onTap: onTap,
        ),
      );
}

class MapWidget extends StatefulWidget {
  const MapWidget({super.key, required this.title});
  final String title;

  @override
  State<MapWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapWidget> {
  double _mapWidth = 1080.0;
  double _mapHeight = 720.0;
  double _cameraHeight = 50.0;
  double _cameraWidth = 50.0;
  double _leftPos = 0.0; //the offset of the map relative to the camera
  double _topPos = 0.0; //the offset of the map relative to the camera

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        _cameraWidth = constraints.maxWidth;
        _cameraHeight = constraints.maxHeight;
        final img = Image.asset(
          'assets/Dragonar_world_map2.png',
          width: _mapWidth,
          height: _mapHeight,
          fit: BoxFit.fill,
        );
        return Center(child: createMap(img));
      }),
    );
  }

  Widget createMap(Image img) {
    return GestureDetector(
      onPanUpdate: (details) {
        var topPos = _topPos + details.delta.dy;
        var leftPos = _leftPos + details.delta.dx;
        topPos = _boundaryRule(topPos, _mapHeight, _cameraHeight);
        leftPos = _boundaryRule(leftPos, _mapWidth, _cameraWidth);
        //set the state
        setState(() {
          _topPos = topPos;
          _leftPos = leftPos;
        });
      },
      child: Container(
        height: _cameraHeight,
        width: _cameraWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 0.8),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: _leftPos + 0,
              top: _topPos + 0,
              child: Container(
                width: img.width,
                height: img.height,
                child: img,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _boundaryRule(position, mapLength, cameraLength) {
    // this function will prevent the widget from moving if it reached the boundary
    if (position < (cameraLength - mapLength)) {
      position = cameraLength - mapLength;
    }
    if (position > 0) {
      position = 0.0;
    }

    return position;
  }
}

class MonsterWidget extends StatelessWidget {
  const MonsterWidget({super.key, required this.monster});
  final Monster monster;

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Text(monster.name),
          monster.imageUrl != ""
              ? getDndApiImage(monster.imageUrl)
              : const Icon(Icons.question_mark),
        ],
      );
}

class AbilityWidget extends StatelessWidget {
  const AbilityWidget(this.content, this.icon, this.controller, {super.key});
  final String content;
  final Icon icon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: TextField(
          decoration: InputDecoration(
              isDense: true,
              icon: icon,
              border: const OutlineInputBorder(),
              labelText: content),
          textAlign: TextAlign.center,
          maxLength: 1,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          scrollPadding: EdgeInsets.zero,
          controller: controller,
        ),
      );
}

class CharacterWidget extends StatefulWidget {
  const CharacterWidget({super.key, required this.game});
  final Game game;

  @override
  State<CharacterWidget> createState() => _CharacterWidget();
}

class _CharacterWidget extends State<CharacterWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: [
        Text("Dungeon Master: ${widget.game.dm}"),
        Text("GameId: ${widget.game.gameId}"),
        Text("Active: ${widget.game.active ? "Yes" : "No"}"),
        Text("Number of players: ${widget.game.players.length}")
      ]),
    );
  }
}

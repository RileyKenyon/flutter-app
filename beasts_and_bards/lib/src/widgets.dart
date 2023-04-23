// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:beasts_and_bards/app_state.dart';
import 'package:flutter/material.dart';
import 'package:beasts_and_bards/game.dart';

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
  final double _mapWidth = 1000.0;
  final double _mapHeight = 1000.0;
  final double _cameraHeight = 500.0;
  final double _cameraWidth = 300.0;
  double _leftPos = 0.0; //the offset of the map relative to the camera
  double _topPos = 0.0; //the offset of the map relative to the camera

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var camera = GestureDetector(
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
        height: 500,
        width: 300,
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
                width: 30,
                height: 30,
                color: Colors.black,
              ),
            ),
            Positioned(
              left: _leftPos + 900,
              top: _topPos + 900,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      body: Center(child: camera),
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

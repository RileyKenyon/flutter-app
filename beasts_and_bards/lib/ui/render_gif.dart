import 'package:flutter/material.dart';

class RenderGif extends StatelessWidget {
  const RenderGif({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
          "images/title.gif",
          height: 250.0,
          width: 250.0,
    );
  }
}

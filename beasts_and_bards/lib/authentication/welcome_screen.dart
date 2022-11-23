import 'package:flutter/material.dart';
import 'package:beasts_and_bards/ui/rounded_button.dart';
import 'package:beasts_and_bards/ui/render_gif.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const RenderGif(),
              RoundedButton(colour: Colors.red, title: 'Log In', onPressed: (){}),
              RoundedButton(
                colour: Colors.red,
                title: 'Create Account',
                onPressed: (){
                  Navigator.pushNamed(context, 'sign_up');
              }),
            ]
          )
      ),
    );
  }
}
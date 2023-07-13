import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Icon(
            Icons.music_note_outlined,
            size: 50.0,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

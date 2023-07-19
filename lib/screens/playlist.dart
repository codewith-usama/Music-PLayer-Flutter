import 'package:flutter/material.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: 70.0),
        decoration: const BoxDecoration(
          color: Color(0xFF6968B7),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(150.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Recent extends StatefulWidget {
  const Recent({super.key});

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: 70.0),
        decoration: const BoxDecoration(
          color: Color(0xFFDEDF7A),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(150.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}

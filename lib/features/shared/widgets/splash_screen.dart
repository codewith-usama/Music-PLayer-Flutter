import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../test.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) => {
      Navigator.of(context).pushReplacement(
    CupertinoPageRoute(builder: (ctx) => const Test())),
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.maxFinite,
        height: double.infinity,
        margin: const EdgeInsets.only(top: 130.0),
        decoration: const BoxDecoration(
          color: Color(0xFF4B4B7B),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(150.0), topRight: Radius.circular(30.0),),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.queue_music,
              color: Colors.white,
              size: 200.0,
            ),
           SizedBox(height: 100.0,),
            Text(
              'my',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 32.0,
              ),
            ),
            Text(
              'player',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

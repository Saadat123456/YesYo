import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'home.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getLoadingText(context);
    return Scaffold(
      body: Center(
          child: Text(
            "Loading...",
            style: TextStyle(fontSize: 25.0),
          )),
    );
  }

  _getLoadingText(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('yesyo.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Timer(
            Duration(seconds: 3),
                () => Navigator.of(context).pushReplacement(_createRoute())
        );
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
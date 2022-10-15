import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyProgressindicator extends StatefulWidget {
  const MyProgressindicator({Key? key}) : super(key: key);

  @override
  State<MyProgressindicator> createState() => _MyProgressindicatorState();
}

class _MyProgressindicatorState extends State<MyProgressindicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSquareCircle(
        size: 60.0,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/Clear.png'),
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30.0)),
          );
        },
      ),
    );
  }
}

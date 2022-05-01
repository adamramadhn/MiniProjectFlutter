import 'package:flutter/material.dart';

Widget containerOpacityWidget(BuildContext context,Color a, Color b , double start, double end) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
      a.withOpacity(start),
      b.withOpacity(end)
    ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
  );
}

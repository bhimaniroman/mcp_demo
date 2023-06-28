//color all

import 'package:flutter/material.dart';

Color? bgcolor;
Color textcolor = const Color(0xff000000);
Color fontcolor = const Color(0xffffffff);
Color blogtextcolor = const Color(0xffACACAC);
Color fontopacitycolor = const Color(0xffffffff).withOpacity(0.7);
Color viewcolor = const Color(0xffF5F5F5);
Color dividercolor = const Color(0xffE0E0E0);
Color buttoncolor = const Color(0xff298BFF);
Color blankbuttoncolor = const Color(0xffD4E0FF);
Color alertcolor = const Color(0xff707070);
Color blogbgcolor = const Color(0xff740a96);
Color orangecolor = const Color(0xFCEF9710);
Color yellowcolor = const Color(0xFCEF9710);

LinearGradient gradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.purple, Colors.blueAccent,
    ]);

List<LinearGradient> ls = [
  const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
    Colors.redAccent,
    Colors.orangeAccent,
  ]),
  const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
    Colors.purpleAccent,
    Colors.pinkAccent,
  ]),
  const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
    Colors.green,
    Colors.greenAccent,
  ]),
  const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
    Colors.lightBlue,
    Colors.lightBlueAccent,
  ]),
  const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
    Colors.redAccent,
    Colors.orange,
  ]),
  const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
    Colors.lightGreen,
    Colors.lightGreenAccent,
  ]),
];

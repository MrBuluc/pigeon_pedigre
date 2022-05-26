import 'package:flutter/cupertino.dart';

Decoration gradient = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [colorOne, colorTwo]));

Color colorOne = const Color.fromRGBO(116, 235, 213, 1);
Color colorTwo = const Color.fromRGBO(172, 182, 229, 1);

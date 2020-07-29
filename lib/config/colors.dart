import 'package:flutter/material.dart';

//gradient colors
const Color GRADIENT_COLOR1 = Color.fromRGBO(168, 5, 254, 1);
const Color GRADIENT_COLOR2 = Color.fromRGBO(219, 55, 185, 1);

//theme colors
const Color WHITE_THEME = Color.fromRGBO(245, 245, 245, 1);
const Color BLACK_THEME = Color.fromRGBO(43, 43, 43, 1);

//current theme

ThemeData currentTheme() => ThemeData(
  primaryColor: WHITE_THEME,
  scaffoldBackgroundColor: WHITE_THEME,
  indicatorColor: BLACK_THEME,
  dividerColor: BLACK_THEME,
  primarySwatch: Colors.grey
);

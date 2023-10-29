// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    // background: Pallete.whiteColor,
    background: Colors.grey,
    // primary: Pallete.backgroundColor,
    primary: Colors.black,
    // secondary: Pallete.borderColor,
    secondary: Colors.grey.shade500,
    // primaryVariant: Pallete.gradient1,
    primaryVariant: Colors.red,
    // secondaryVariant: Pallete.gradient2
    secondaryVariant: Colors.red.shade500,
  ),
);

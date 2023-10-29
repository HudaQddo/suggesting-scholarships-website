// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:frontend/pallete.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Pallete.whiteColor,
    primary: Pallete.backgroundColor,
    secondary: Pallete.borderColor,
    primaryVariant: Pallete.gradient1,
    secondaryVariant: Pallete.gradient2,
  ),
);

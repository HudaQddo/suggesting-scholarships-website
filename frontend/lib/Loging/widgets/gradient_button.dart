// ignore_for_file: prefer_const_constructors, no_logic_in_create_state, sort_child_properties_last, unused_import, prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/Loging/completeInformation.dart';
import 'package:frontend/scholarships/scholarships.dart';
import '../../pallete.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final fun;
  const GradientButton({
    super.key,
    required this.text,
    required this.fun,
  });

  @override
  State<GradientButton> createState() =>
      _GradientButtonState(text: text, fun: fun);
}

class _GradientButtonState extends State<GradientButton> {
  String text;
  var fun;
  _GradientButtonState({
    required this.text,
    required this.fun,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fun,
      child: AnimatedContainer(
        width: text == 'Cancel' || text == 'Save'
            ? 140
            : text == 'Search'
                ? 100
                : text == 'Show'
                    ? 75
                    : 300,
        height: text == 'Show'
            ? 30
            : text == 'Search'
                ? 40
                : 55,
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: text == "Cancel"
              ? Border.all(color: Colors.grey, width: 1)
              : null,
          gradient: text != 'Cancel'
              ? LinearGradient(
                  colors: [
                    // Pallete.gradient1,
                    Theme.of(context).colorScheme.primaryVariant,
                    // Pallete.gradient2,
                    Theme.of(context).colorScheme.secondaryVariant
                    // Pallete.gradient3,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )
              : null,
          color: text == 'Cancel' ? Colors.white12 : null,
          boxShadow: text == 'Cancel'
              ? null
              : [
                  BoxShadow(
                    // color: Pallete.gradient1,
                    color: Theme.of(context).colorScheme.primaryVariant,
                    blurRadius: 5,
                  ),
                ],
        ),
        duration: Duration(milliseconds: 700),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: text != 'Show' ? 17 : null,
          ),
        ),
      ),
    );
  }
}

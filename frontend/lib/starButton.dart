// ignore_for_file: no_logic_in_create_state, implementation_imports, unnecessary_import, prefer_typing_uninitialized_variables, prefer_const_constructors, unused_import, file_names, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/scholarships/models/scholarship_model.dart';

import 'MyList/my_list_provider.dart';
import 'consts.dart';
import 'pallete.dart';

class StarButton extends StatefulWidget {
  final ScholarshipModel scholarship;
  final BuildContext contextFather;
  const StarButton(
      {required this.scholarship, required this.contextFather, super.key});

  @override
  State<StarButton> createState() =>
      _StarButtonState(scholarship: scholarship, contextFather: contextFather);
}

class _StarButtonState extends State<StarButton> {
  ScholarshipModel scholarship;
  BuildContext contextFather;

  _StarButtonState({required this.scholarship, required this.contextFather});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (scholarship.inList) {
            provider.removeFromList(scholarship);
            scholarship.inList = false;
          } else {
            scholarship.inList = true;
            provider.addToList(scholarship);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(15),
        child: Icon(
          scholarship.inList ? Icons.star : Icons.star_border,
          // color: Pallete.gradient2,
          color: Theme.of(context).colorScheme.secondaryVariant,
        ),
      ),
    );
  }
}

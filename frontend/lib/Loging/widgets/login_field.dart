// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable, no_logic_in_create_state, unused_import

import 'package:flutter/material.dart';
import '../../pallete.dart';

class LoginField extends StatefulWidget {
  final String hintText;
  final bool isPass;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String firstPassword;

  const LoginField({
    required this.hintText,
    required this.isPass,
    required this.textInputType,
    required this.controller,
    required this.firstPassword,
    super.key,
  });

  @override
  State<LoginField> createState() => _LoginFieldState(
        hintText: hintText,
        isPass: isPass,
        textInputType: textInputType,
        controller: controller,
        firstPassword: firstPassword,
      );
}

class _LoginFieldState extends State<LoginField> {
  final _formKey = GlobalKey<FormState>();

  String hintText;
  bool isPass;
  TextInputType textInputType;
  TextEditingController controller;
  String firstPassword;
  _LoginFieldState({
    required this.hintText,
    required this.isPass,
    required this.textInputType,
    required this.controller,
    required this.firstPassword,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 300,
      ),
      // child: Form(
      //   key: _formKey,
      //   child: TextFormField(
      //     controller: controller,
      //     keyboardType: textInputType,
      //     obscureText: isPass,
      //     validator: (value) {
      //       if (value == null || value.isEmpty) {
      //         return 'Can\'t be empty';
      //       }
      //       if (hintText == "Email" && !value.endsWith('@gmail.com')) {
      //         return "This email is valid";
      //       } else if (hintText.contains("Password") && value.length < 8) {
      //         return 'Too short';
      //       }
      //       return null;
      //     },
      //     onChanged: (value) {
      //       setState(() {
      //         if (_formKey.currentState!.validate()) {}
      //       });
      //       return;
      //     },
      //     decoration: InputDecoration(
      //       contentPadding: const EdgeInsets.all(27),
      //       enabledBorder: OutlineInputBorder(
      //         borderSide: const BorderSide(
      //           color: Colors.grey,
      //           width: 3,
      //         ),
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       focusedBorder: OutlineInputBorder(
      //         borderSide: BorderSide(
      //           color: Colors.grey,
      //           width: 3,
      //         ),
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       hintText: hintText,
      //       prefixIcon: Icon(hintText == "Email"
      //           ? Icons.email
      //           : hintText.contains("Password")
      //               ? Icons.lock
      //               : hintText.contains("Name")
      //                   ? Icons.text_format
      //                   : hintText.contains("Age")
      //                       ? Icons.person
      //                       : hintText.contains("Country")
      //                           ? Icons.title
      //                           : null),
      //       suffixIcon:
      //           hintText.contains("Password") && controller.text.isNotEmpty
      //               ? IconButton(
      //                   icon: Icon(
      //                     isPass ? Icons.visibility : Icons.visibility_off,
      //                     // color: Pallete.whiteColor,
      //                   ),
      //                   onPressed: () {
      //                     setState(
      //                       () {
      //                         isPass = !isPass;
      //                       },
      //                     );
      //                   },
      //                 )
      //               : null,
      //     ),
      //   ),
      // ),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: textInputType,
          obscureText: isPass,
          validator: (value) {
            print("$value \t $firstPassword");
            if (value == null || value.isEmpty) {
              return 'Can\'t be empty';
            }
            if (hintText == "Email" && !value.endsWith('@gmail.com')) {
              return "This email is valid";
            } else if (hintText == "Password" && value.length < 8) {
              return 'Too short';
            } else if (hintText == "Confirm Password" && value != firstPassword) {
              return 'Not match';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              if (_formKey.currentState!.validate()) {}
            });
            return;
          },
          onTap: () {
            setState(() {
              if (_formKey.currentState!.validate()) {}
            });
            return;
          },
          onFieldSubmitted: (value) {
            setState(() {
              if (_formKey.currentState!.validate()) {}
            });
            return;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: hintText,
            prefixIcon: Icon(hintText == "Username"
                ? Icons.text_format
                : hintText == "Email"
                    ? Icons.email
                    : hintText.contains("Password")
                        ? Icons.lock
                        : hintText.contains("Name")
                            ? Icons.text_format
                            : hintText.contains("Age")
                                ? Icons.person
                                : hintText.contains("Country")
                                    ? Icons.title
                                    : null),
            suffixIcon:
                hintText.contains("Password") && controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          isPass ? Icons.visibility : Icons.visibility_off,
                          // color: Pallete.whiteColor,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              isPass = !isPass;
                            },
                          );
                        },
                      )
                    : null,
          ),
        ),
      ),
    );
  }
}

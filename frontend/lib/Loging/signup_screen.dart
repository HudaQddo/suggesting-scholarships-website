// ignore_for_file: prefer_const_constructors, prefer_final_fields, sort_child_properties_last, unnecessary_string_interpolations, avoid_print, unused_import, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Loging/login_screen.dart';
import '../components.dart';
import '../consts.dart';
import '../main_page.dart';
import '../pallete.dart';
import '../scholarships/scholarship_api.dart';
import '../scholarships/scholarships.dart';
import 'completeInformation.dart';
import 'widgets/gradient_button.dart';
import 'widgets/login_field.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKeyUsername = GlobalKey<FormState>();
  var formKeyEmail = GlobalKey<FormState>();
  var formKeyPassword = GlobalKey<FormState>();
  var formKeyConfirmPassword = GlobalKey<FormState>();

  bool isPass = true;
  bool isConfirmPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.network(
            'asset/backgrounds/background6.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Sign up".toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    Image.network('asset/images/graduate.png'),
                  ],
                ),
                Container(
                  width: 700,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: formKeyUsername,
                        child: addFormField(
                          context: context,
                          controller: usernameController,
                          textInputType: TextInputType.text,
                          text: 'Username',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              if (formKeyUsername.currentState!.validate()) {}
                            });
                            return;
                          },
                          onSubmitted: (value) {
                            setState(() {
                              if (formKeyUsername.currentState!.validate()) {}
                            });
                            return;
                          },
                          prefixIxon: (Icons.text_format),
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: formKeyEmail,
                        child: addFormField(
                          context: context,
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          text: 'Email',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Can\'t be empty';
                            } else if (!value
                                    .toString()
                                    .endsWith('@gmail.com') ||
                                value.length <= 10) {
                              return 'Email Invalid';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              if (formKeyEmail.currentState!.validate()) {}
                            });
                            return;
                          },
                          onSubmitted: (value) {
                            setState(() {
                              if (formKeyEmail.currentState!.validate()) {}
                            });
                            return;
                          },
                          prefixIxon: (Icons.mail),
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: formKeyPassword,
                        child: addFormField(
                          context: context,
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          isPass: isPass,
                          text: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Can\'t be empty';
                            } else if (value.length < 8) {
                              return 'Too short';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              if (formKeyPassword.currentState!.validate()) {}
                            });
                            return;
                          },
                          onSubmitted: (value) {
                            setState(() {
                              if (formKeyPassword.currentState!.validate()) {}
                            });
                            return;
                          },
                          onPressedEyePassword: () {
                            setState(
                              () {
                                isPass = !isPass;
                              },
                            );
                          },
                          prefixIxon: (Icons.lock),
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: formKeyConfirmPassword,
                        child: addFormField(
                          context: context,
                          controller: confirmPasswordController,
                          textInputType: TextInputType.visiblePassword,
                          isPass: isConfirmPass,
                          text: 'Confirm Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Can\'t be empty';
                            } else if (passwordController.text != value) {
                              return 'Not Match';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              if (formKeyConfirmPassword.currentState!
                                  .validate()) {}
                            });
                            return;
                          },
                          onSubmitted: (value) {
                            setState(() {
                              if (formKeyConfirmPassword.currentState!
                                  .validate()) {}
                            });
                            return;
                          },
                          onPressedEyePassword: () {
                            setState(
                              () {
                                isConfirmPass = !isConfirmPass;
                              },
                            );
                          },
                          prefixIxon: (Icons.lock),
                        ),
                      ),
                      SizedBox(height: 20),
                      GradientButton(
                        text: 'Sign up',
                        fun: () {
                          setState(() {
                            if (formKeyUsername.currentState!.validate() &&
                                formKeyEmail.currentState!.validate() &&
                                formKeyPassword.currentState!.validate() &&
                                formKeyConfirmPassword.currentState!
                                    .validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompleteInformation(
                                    username: usernameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              );
                            }
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Do you have an account already?',
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              'sign in',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

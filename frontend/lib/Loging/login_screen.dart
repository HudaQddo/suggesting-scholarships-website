// ignore_for_file: prefer_const_constructors, prefer_final_fields, sort_child_properties_last, unnecessary_string_interpolations, avoid_print, unused_import, sized_box_for_whitespace, use_build_context_synchronously, unused_local_variable, avoid_unnecessary_containers, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Loging/signup_screen.dart';
import 'package:frontend/main_page.dart';
import '../MyList/my_list_api.dart';
import '../components.dart';
import '../consts.dart';
import '../pallete.dart';
import '../scholarships/scholarship_api.dart';
import '../scholarships/scholarships.dart';
import '../universities/university_api.dart';
import 'completeInformation.dart';
import 'widgets/gradient_button.dart';
import 'widgets/login_field.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKeyUsername = GlobalKey<FormState>();
  var formKeyPassword = GlobalKey<FormState>();
  bool isPass = true;

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
            padding: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Sign in'.toUpperCase(),
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
                      // Username
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
                      SizedBox(height: 30),
                      // Password
                      Form(
                        key: formKeyPassword,
                        child: addFormField(
                          context: context,
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          text: 'Password',
                          isPass: isPass,
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
                      SizedBox(height: 30),
                      // Login Button
                      GradientButton(
                        text: 'Sign in',
                        fun: () async {
                          bool done = await login();
                          if (done) {
                            usernameLocal = usernameController.text;
                            passwordLocal = passwordController.text;
                            await setToken();
                            await getBucket();
                            // setUniversity(await getAllUniversities(1));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Error"),
                                content:
                                    Text("Username or Password is Invalid"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // color: Pallete.gradient1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryVariant,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(14),
                                      child: Text(
                                        "OK",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      // Go to the Signup Page
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Do you not have an account yet?',
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              'sign up',
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

  Future<bool> login() async {
    var response = await http.post(
      Uri.parse('$localhost/project/applicants/login/'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: {
        "username": usernameController.text,
        "password": passwordController.text,
      },
      encoding: Encoding.getByName("utf-8"),
    );
    setUser(usernameController.text, passwordController.text);
    return jsonDecode(response.body)['id'] != null;
  }
}

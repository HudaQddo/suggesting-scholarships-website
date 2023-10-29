// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, sized_box_for_whitespace, prefer_final_fields, no_logic_in_create_state, sort_child_properties_last, unused_field, avoid_print, use_build_context_synchronously, unused_local_variable, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Loging/widgets/login_field.dart';
import 'package:frontend/MyList/my_list_api.dart';
import 'package:frontend/main_page.dart';
import 'package:frontend/pallete.dart';
import 'package:intl/intl.dart';
import '../components.dart';
import '../consts.dart';
import '../scholarships/scholarship_api.dart';
import '../scholarships/scholarships.dart';
import 'widgets/gradient_button.dart';
import 'package:http/http.dart' as http;

class CompleteInformation extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  const CompleteInformation({
    required this.username,
    required this.email,
    required this.password,
    super.key,
  });

  @override
  State<CompleteInformation> createState() => _CompleteInformationState(
        username: username,
        email: email,
        password: password,
      );
}

class _CompleteInformationState extends State<CompleteInformation> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var majorController = TextEditingController();
  var birthDateController = TextEditingController();
  var countryController = TextEditingController();
  var nationalityController = TextEditingController();

  var formKeyFirstName = GlobalKey<FormState>();
  var formKeyLastName = GlobalKey<FormState>();
  var formKeyPhoneNumber = GlobalKey<FormState>();
  var formKeyMajor = GlobalKey<FormState>();
  var formKeyBirthDate = GlobalKey<FormState>();
  var formKeyGender = GlobalKey<FormState>();
  var formKeyDegreeLevel = GlobalKey<FormState>();
  var formKeyStudyStatus = GlobalKey<FormState>();
  var formKeyCountry = GlobalKey<FormState>();
  var formKeyNationality = GlobalKey<FormState>();

  int valueDay = 0;
  int valueMonth = 0;
  int valueYears = 0;
  String valueCountry = 'Syria';
  List<String> countries = [
    'Syria',
    'Germany',
    'Italy',
    'Lebanon',
    'Iraq',
    'USA',
    'Turkey'
  ];
  String valueNationality = 'Syria';
  List<String> nationalities = [
    'Syria',
    'Germany',
    'Italy',
    'Lebanon',
    'Iraq',
    'USA',
    'Turkey'
  ];
  String valueStudyStatus = 'student';
  List<String> studyStatus = [
    'student',
    'graduate',
  ];
  String valueDegreeLevel = 'bachelor';
  List<String> degreeLevels = [
    'bachelor',
    'diploma',
    'master',
    'phd',
  ];
  String _gender = 'Female';
  bool _clicked = false, _opacity = false;

  @override
  void initState() {
    super.initState();
  }

  String username;
  String email;
  String password;
  _CompleteInformationState({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                      "fill your information".toUpperCase(),
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
                      // First & Last Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            key: formKeyFirstName,
                            child: addFormField(
                              context: context,
                              controller: firstNameController,
                              textInputType: TextInputType.text,
                              text: 'First Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Can\'t be empty';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (formKeyFirstName.currentState!
                                      .validate()) {}
                                });
                                return;
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  if (formKeyFirstName.currentState!
                                      .validate()) {}
                                });
                                return;
                              },
                              prefixIxon: (Icons.text_format),
                            ),
                          ),
                          Form(
                            key: formKeyLastName,
                            child: addFormField(
                              context: context,
                              controller: lastNameController,
                              textInputType: TextInputType.text,
                              text: 'Last Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Can\'t be empty';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (formKeyLastName.currentState!
                                      .validate()) {}
                                });
                                return;
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  if (formKeyLastName.currentState!
                                      .validate()) {}
                                });
                                return;
                              },
                              prefixIxon: (Icons.text_format),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      // Phone Number & Major
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            key: formKeyPhoneNumber,
                            child: addFormField(
                              context: context,
                              controller: phoneNumberController,
                              textInputType: TextInputType.number,
                              text: 'Phone Number',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Can\'t be empty';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (formKeyPhoneNumber.currentState!
                                      .validate()) {}
                                });
                                return;
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  if (formKeyPhoneNumber.currentState!
                                      .validate()) {}
                                });
                                return;
                              },
                              prefixIxon: (Icons.phone),
                            ),
                          ),
                          Form(
                            key: formKeyMajor,
                            child: addFormField(
                              context: context,
                              controller: majorController,
                              textInputType: TextInputType.text,
                              text: 'Major',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Can\'t be empty';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (formKeyMajor.currentState!.validate()) {}
                                });
                                return;
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  if (formKeyMajor.currentState!.validate()) {}
                                });
                                return;
                              },
                              prefixIxon: (Icons.school),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      // Birth Date & Gender
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 300,
                            child: Form(
                              key: formKeyBirthDate,
                              child: DateTimeField(
                                controller: birthDateController,
                                format: DateFormat('yyy-MM-dd'),
                                decoration: InputDecoration(
                                  labelText: 'Birthday',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      // color: Pallete.gradient1.withOpacity(0.5),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant
                                          .withOpacity(0.5),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      // color: Pallete.gradient1,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      // color: Pallete.gradient1,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.cake,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryVariant,
                                  ),
                                ),
                                onShowPicker: (context, currentValue) {
                                  return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );
                                },
                                onChanged: (value) {
                                  setState(() {
                                    valueDay = value!.day;
                                    valueMonth = value.month;
                                    valueYears = value.year;
                                  });
                                },
                              ),
                            ),
                          ),
                          Form(
                            key: formKeyGender,
                            child: addDropDownForm(
                              value: _gender,
                              text: 'Gender',
                              itemsvalue: ['Female', 'Male'],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your gender';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (formKeyGender.currentState!.validate()) {}
                                  _gender = value!;
                                });
                                return;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      // Residency & Nationality
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            key: formKeyCountry,
                            child: addFormField(
                              context: context,
                              controller: countryController,
                              textInputType: TextInputType.text,
                              text: 'Residency',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a country';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (formKeyCountry.currentState!
                                      .validate()) {}
                                  // valueCountry = value!;
                                });
                                return;
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  if (formKeyCountry.currentState!
                                      .validate()) {}
                                  // valueCountry = value!;
                                });
                                return;
                              },
                              prefixIxon: (Icons.language),
                            ),
                          ),
                          Form(
                            key: formKeyNationality,
                            child: addFormField(
                              context: context,
                              controller: nationalityController,
                              textInputType: TextInputType.text,
                              text: 'Nationality',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a country';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (formKeyNationality.currentState!
                                      .validate()) {}
                                  // valueCountry = value!;
                                });
                                return;
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  if (formKeyNationality.currentState!
                                      .validate()) {}
                                  // valueCountry = value!;
                                });
                                return;
                              },
                              prefixIxon: (Icons.language),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      // Degree Level & Study Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            key: formKeyDegreeLevel,
                            child: addDropDownForm(
                              value: valueDegreeLevel,
                              text: 'Degree Level',
                              itemsvalue: degreeLevels,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your degree level';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (formKeyDegreeLevel.currentState!
                                      .validate()) {}
                                  degreeLevels = value!;
                                });
                                return;
                              },
                            ),
                          ),
                          Form(
                            key: formKeyStudyStatus,
                            child: addDropDownForm(
                              value: valueStudyStatus,
                              text: 'Study Status',
                              itemsvalue: studyStatus,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your study status';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (formKeyStudyStatus.currentState!
                                      .validate()) {}
                                  valueStudyStatus = value!;
                                });
                                return;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      // Cancel & Submit Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 300,
                            child: GradientButton(
                              text: 'Cancel',
                              fun: () async {
                                Navigator.pop(
                                  context,
                                );
                              },
                            ),
                          ),
                          Container(
                            width: 300,
                            child: GradientButton(
                              text: 'Submit',
                              fun: () async {
                                // print(formKeyBirthDate.currentState);
                                setState(() {
                                  // print("Submit");
                                  if (formKeyFirstName.currentState!
                                          .validate() &&
                                      formKeyLastName.currentState!
                                          .validate() &&
                                      formKeyPhoneNumber.currentState!
                                          .validate() &&
                                      formKeyMajor.currentState!.validate() &&
                                      valueDay != 0 &&
                                      valueMonth != 0 &&
                                      valueYears != 0) {
                                    // print("Inner IF");
                                    createUser();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainPage(),
                                      ),
                                    );
                                  }
                                });
                              },
                            ),
                          ),
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

  addDropDownForm({
    required String value,
    required String text,
    required List<String> itemsvalue,
    required var validator,
    required var onChanged,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 300,
        maxHeight: 50,
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        style: TextStyle(fontSize: textSize1),
        decoration: InputDecoration(
          labelText: text,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Pallete.gradient1.withOpacity(0.5),
              color:
                  Theme.of(context).colorScheme.primaryVariant.withOpacity(0.5),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Pallete.gradient1,
              color: Theme.of(context).colorScheme.primaryVariant,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Pallete.gradient1,
              color: Theme.of(context).colorScheme.primaryVariant,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        items: itemsvalue.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }

  Future createUser() async {
    var response = await http.post(
      Uri.parse('$localhost/project/applicants/register/'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: {
        "username": username,
        "email_address": email,
        "password": password,
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
        "birth_date": "$valueYears-$valueMonth-$valueDay",
        "gender": _gender == "Male" ? "M" : "F",
        "country": valueCountry,
        "nationality": valueNationality,
        "phone_number": phoneNumberController.text,
        "degree_level": valueDegreeLevel,
        "major": majorController.text,
        "study_status": valueStudyStatus == "student" ? "S" : "G"
      },
      encoding: Encoding.getByName("utf-8"),
    );
    setUser(username, password);
    await setToken();
    await getBucket();
  }
}

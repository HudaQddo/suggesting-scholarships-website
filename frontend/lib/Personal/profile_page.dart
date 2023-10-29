// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, implementation_imports, unnecessary_import, unused_import, avoid_print, prefer_final_fields, unused_local_variable, deprecated_member_use

import 'dart:math';

// import 'package:dob_input_field/dob_input_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:frontend/Personal/profile_api.dart';
import 'package:frontend/components.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/sidebar/widget/navigation_drawer_widget.dart';
import 'package:intl/intl.dart';
import '../Loging/widgets/gradient_button.dart';
import 'Models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var majorController = TextEditingController();
  var birthDateController = TextEditingController();
  var countryController = TextEditingController();
  var nationalityController = TextEditingController();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

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
  var formKeyUsername = GlobalKey<FormState>();
  var formKeyEmail = GlobalKey<FormState>();
  var formKeyPassword = GlobalKey<FormState>();
  var formKeyConfirmPassword = GlobalKey<FormState>();

  int valueDay = 1;
  int valueMonth = 1;
  int valueYears = 2000;
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
  bool editPassword = false;
  UserModel user = UserModel(
    id: 0,
    username: "",
    firstName: "",
    lastName: "",
    email: "",
    gender: "",
    phoneNumber: "",
    nationality: "",
    country: "",
    birthdate: "",
    degreeLevel: "",
    major: "",
    studyStatus: "",
  );

  @override
  void initState() {
    super.initState();
    setInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: addAppBar(context, 'Profile', false),
      body: SafeArea(
        child: FutureBuilder<UserModel>(
          future: getProfile(),
          initialData: user,
          builder: ((context, snapshot) {
            UserModel data = snapshot.data as UserModel;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      _gender == "Female"
                          ? 'asset/images/female.gif'
                          : 'asset/images/male.gif',
                      width: min(MediaQuery.of(context).size.height,
                              MediaQuery.of(context).size.width) /
                          2,
                    ),
                    SizedBox(height: 25),
                    // Cancel and Save Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: GradientButton(
                            text: 'Save',
                            fun: () async {
                              UserModel temp = UserModel(
                                id: data.id,
                                username: usernameController.text,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                gender: _gender == "Female" ? "F" : "M",
                                phoneNumber: phoneNumberController.text,
                                nationality: nationalityController.text,
                                country: countryController.text,
                                birthdate: "$valueYears-$valueMonth-$valueDay",
                                degreeLevel: valueDegreeLevel,
                                major: majorController.text,
                                studyStatus:
                                    valueStudyStatus == "student" ? "S" : "G",
                              );
                              editProfile(temp);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 700,
                  padding: EdgeInsets.all(25),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Username & Email
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Form(
                              key: formKeyUsername,
                              child: addFormField(
                                context: context,
                                controller: usernameController,
                                textInputType: TextInputType.text,
                                text: 'Username',
                                validator: (value) {},
                                onChanged: (value) {},
                                onSubmitted: (value) {},
                                prefixIxon: (Icons.text_format),
                              ),
                            ),
                            Form(
                              key: formKeyEmail,
                              child: addFormField(
                                context: context,
                                controller: emailController,
                                textInputType: TextInputType.emailAddress,
                                text: 'Email',
                                validator: (value) {},
                                onChanged: (value) {},
                                onSubmitted: (value) {},
                                prefixIxon: (Icons.mail),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
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
                                validator: (value) {},
                                onChanged: (value) {},
                                onSubmitted: (value) {},
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
                                validator: (value) {},
                                onChanged: (value) {},
                                onSubmitted: (value) {},
                                prefixIxon: (Icons.text_format),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        // // Check Box
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: editPassword,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           editPassword = value!;
                        //           passwordController.text = '';
                        //           confirmPasswordController.text = '';
                        //         });
                        //       },
                        //     ),
                        //     Text('Edit Password'),
                        //   ],
                        // ),
                        // // Password & Confirm Password
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Form(
                        //       key: formKeyPassword,
                        //       child: addFormField(
                        //         context: context,
                        //         controller: passwordController,
                        //         textInputType: TextInputType.visiblePassword,
                        //         isPass: true,
                        //         readOnly: !editPassword,
                        //         text: 'Passowrd',
                        //         validator: (value) {},
                        //         onChanged: (value) {},
                        //         onSubmitted: (value) {},
                        //         prefixIxon: (Icons.lock),
                        //       ),
                        //     ),
                        //     Form(
                        //       key: formKeyConfirmPassword,
                        //       child: addFormField(
                        //         context: context,
                        //         controller: confirmPasswordController,
                        //         textInputType: TextInputType.visiblePassword,
                        //         isPass: true,
                        //         readOnly: !editPassword,
                        //         text: 'Confirm Passowrd',
                        //         validator: (value) {},
                        //         onChanged: (value) {},
                        //         onSubmitted: (value) {},
                        //         prefixIxon: (Icons.lock),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 25),

                        // Major & Birth Date
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Form(
                              key: formKeyMajor,
                              child: addFormField(
                                context: context,
                                controller: majorController,
                                textInputType: TextInputType.text,
                                text: 'Major',
                                validator: (value) {},
                                onChanged: (value) {},
                                onSubmitted: (value) {},
                                prefixIxon: (Icons.school),
                              ),
                            ),
                            // Container(
                            //   width: 300,
                            //   child: DOBInputField(
                            //     dateFormatType: DateFormatType.DDMMYYYY,
                            //     key: formKeyBirthDate,
                            //     firstDate: DateTime(1900),
                            //     lastDate: DateTime.now(),
                            //     showLabel: true,
                            //     showCursor: true,
                            //     initialDate:
                            //         DateTime(valueYears, valueMonth, valueDay),
                            //     autovalidateMode:
                            //         AutovalidateMode.onUserInteraction,
                            //     fieldLabelText: "Birth Date",
                            //     errorFormatText: 'The Date is Invalid',
                            //     onDateSaved: (value) {
                            //       setState(() {
                            //         valueDay = value.day;
                            //         valueMonth = value.month;
                            //         valueYears = value.year;
                            //       });
                            //     },
                            //     onDateSubmitted: (value) {
                            //       setState(() {
                            //         valueDay = value.day;
                            //         valueMonth = value.month;
                            //         valueYears = value.year;
                            //         // print(valueDay.toString().padLeft(2, '0'));
                            //       });
                            //     },
                            //     inputDecoration: InputDecoration(
                            //       contentPadding: EdgeInsets.all(10),
                            //       enabledBorder: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //           // color: Pallete.gradient1.withOpacity(0.5),
                            //           color: Theme.of(context)
                            //               .colorScheme
                            //               .primaryVariant
                            //               .withOpacity(0.5),
                            //           width: 2,
                            //         ),
                            //         borderRadius: BorderRadius.circular(5),
                            //       ),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //           // color: Pallete.gradient1,
                            //           color: Theme.of(context)
                            //               .colorScheme
                            //               .primaryVariant,
                            //           width: 2,
                            //         ),
                            //         borderRadius: BorderRadius.circular(5),
                            //       ),
                            //       border: OutlineInputBorder(
                            //         borderSide: BorderSide(
                            //           // color: Pallete.gradient1,
                            //           color: Theme.of(context)
                            //               .colorScheme
                            //               .primaryVariant,
                            //           width: 2,
                            //         ),
                            //         borderRadius: BorderRadius.circular(5),
                            //       ),
                            //       prefixIcon: Icon(
                            //         Icons.cake,
                            //         // color: Pallete.gradient1,
                            //         color: Theme.of(context)
                            //             .colorScheme
                            //             .primaryVariant,
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
                                      initialDate:
                                          currentValue ?? DateTime.now(),
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
                        // Phone Number & Gender
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Form(
                              key: formKeyPhoneNumber,
                              child: addFormField(
                                context: context,
                                controller: phoneNumberController,
                                textInputType: TextInputType.text,
                                text: 'Phone Number',
                                validator: (value) {},
                                onChanged: (value) {},
                                onSubmitted: (value) {},
                                prefixIxon: (Icons.phone),
                              ),
                            ),
                            Container(
                              width: 300,
                              child: Form(
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
                                      if (formKeyGender.currentState!
                                          .validate()) {}
                                      _gender = value!;
                                    });
                                    return;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25), // Degree Level & Study Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 300,
                              child: Form(
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
                                      valueDegreeLevel = value!;
                                    });
                                    return;
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 300,
                              child: Form(
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
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
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
    return DropdownButtonFormField<String>(
      value: value,
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
    );
  }

  void setInfo() async {
    UserModel userModel = await getProfile();
    usernameController.text = userModel.username;
    emailController.text = userModel.email;
    firstNameController.text = userModel.firstName;
    lastNameController.text = userModel.lastName;
    phoneNumberController.text = userModel.phoneNumber;
    majorController.text = userModel.major;
    countryController.text = userModel.country;
    nationalityController.text = userModel.nationality;
    List<String> date = userModel.birthdate.split('-');
    setState(() {
      valueYears = int.parse(date[0]);
      valueMonth = int.parse(date[1]);
      valueDay = int.parse(date[2]);
      birthDateController.text = '$valueYears-$valueMonth-$valueDay';
      _gender = userModel.gender == "F" ? "Female" : "Male";
      valueDegreeLevel = userModel.degreeLevel;
      valueStudyStatus = userModel.studyStatus == "S" ? "student" : "graduate";
    });
  }
}

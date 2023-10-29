// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, avoid_print, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously, deprecated_member_use, sized_box_for_whitespace

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:frontend/Loging/widgets/gradient_button.dart';
import 'package:frontend/consts.dart';
import 'package:frontend/main_page.dart';
import 'package:frontend/scholarships/models/scholarship_and_related_model.dart';
import 'package:frontend/scholarships/models/scholarship_model.dart';
import 'package:frontend/scholarships/recommendation_form_page.dart';
import 'package:frontend/scholarships/scholarship_api.dart';
import 'package:frontend/universities/model/university_and_related_model.dart';
import 'package:frontend/universities/universities.dart';
import 'package:frontend/universities/university_page.dart';
import 'universities/model/university_model.dart';
import 'scholarships/scholarship_page.dart';
import 'scholarships/scholarships.dart';
import 'starButton.dart';
import 'package:http/http.dart' as http;
import 'universities/university_api.dart';

addAppBar(context, whichActive, isBack) {
  return AppBar(
    // automaticallyImplyLeading: false,
    // backgroundColor: Pallete.backgroundColor,
    backgroundColor: Theme.of(context).colorScheme.primary,
    toolbarHeight: 75,
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(isBack ? Icons.arrow_back : Icons.menu),
        onPressed: () {
          if (isBack) {
            Navigator.pop(context);
          } else {
            Scaffold.of(context).openDrawer();
          }
        },
      ),
    ),
    title: Row(
      children: [
        Container(
          child: Row(
            children: [
              Image.network(
                'asset/images/logo.png',
                width: 50,
                // color: Pallete.whiteColor,
                color: Theme.of(context).colorScheme.background,
              ),
              SizedBox(width: 10),
              Text(websiteTitle),
            ],
          ),
        ),
        SizedBox(width: 100),
        Container(
          child: Row(
            children: [
              buttonAppBar(
                context,
                'Home',
                whichActive,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                  );
                },
              ),
              SizedBox(width: 20),
              buttonAppBar(
                context,
                'Scholarships',
                whichActive,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Scholarships(forYou: {}, major: '', location: ''),
                    ),
                  );
                },
              ),
              SizedBox(width: 20),
              buttonAppBar(
                context,
                'Universities',
                whichActive,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Universities(major: '', location: ''),
                    ),
                  );
                },
              ),
              SizedBox(width: 20),
              // buttonAppBar(
              //   'My List',
              //   whichActive,
              //   () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => MyListPage(),
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(width: 20),
              // buttonAppBar(
              //   'Profile',
              //   whichActive,
              //   () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => ProfilePage(),
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(width: 20),
              buttonAppBar(
                context,
                'Recommendation',
                whichActive,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecommendationFormPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

buttonAppBar(context, text, whichActive, fun) {
  return InkWell(
    onTap: fun,
    child: Text(
      text,
      style: TextStyle(
          color: whichActive == text
              ? Theme.of(context).colorScheme.secondaryVariant
              : null),
    ),
  );
}

addPaddingAll(double value) {
  return EdgeInsets.all(value);
}

addLine() {
  return Container(
    width: double.infinity,
    height: 2,
    color: Colors.grey.shade400,
  );
}

addCardScholarship(BuildContext context, ScholarshipModel scholarship) {
  return Column(
    children: [
      Container(
        width: 300,
        height: 400,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    // University Image
                    ClipRRect(
                      child: Image.network(
                        scholarship.image,
                        color: Colors.grey.withOpacity(0.7),
                        colorBlendMode: BlendMode.modulate,
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    // University Name
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        scholarship.universities,
                        style: TextStyle(
                          fontSize: 16,
                          // color: Pallete.whiteColor,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                  ],
                ),
                StarButton(
                  scholarship: scholarship,
                  contextFather: context,
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: 300,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Location
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 15,
                            ),
                            Text(
                              // scholarship.universities[0].location.name,
                              scholarship.location,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Scholarship Name
                        Text(
                          scholarship.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            // color: Pallete.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    // Degree Level & Study Type
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(scholarship.degreeLevel),
                        Text(scholarship.studyType),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // // Fees
                        // Text(
                        //   scholarship.fees.toString(),
                        //   style: TextStyle(
                        //     color: Colors.green,
                        //     // color: Colors.blue,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),

                        // Show Button
                        Container(
                          child: GradientButton(
                            text: 'Show',
                            fun: () async {
                              ScholarshipAndRelatedModel scholarshipModel =
                                  await getScholarship(scholarship.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScholarshipPage(
                                      scholarshipModel: scholarshipModel),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

addCardUniversity(BuildContext context, UniversityModel university) {
  return Column(
    children: [
      Container(
        width: 300,
        height: 350,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          // color: Pallete.whiteColor,
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              // color: Pallete.borderColor.withOpacity(0.2),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                // University Image
                ClipRRect(
                  child: Image.network(
                    university.image,
                    color: Colors.grey.withOpacity(0.7),
                    colorBlendMode: BlendMode.modulate,
                    width: 300,
                    height: 175,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                // University Name
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    university.name,
                    style: TextStyle(
                      fontSize: 16,
                      // color: Pallete.whiteColor,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: 300,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          university.location,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                    // Link
                    Link(
                      uri: Uri.parse(university.website),
                      builder: ((context, followLink) {
                        return TextButton(
                          onPressed: followLink,
                          child: Text(university.website),
                        );
                      }),
                    ),
                    // Show Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Text(
                        //   scholarship.fees,
                        //   style: TextStyle(
                        //     // fontSize: 18,
                        //     color: Colors.green,
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => const UniversityPage(),
                        //       ),
                        //     );
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(
                        //       vertical: 5,
                        //       horizontal: 10,
                        //     ),
                        //     decoration: BoxDecoration(
                        //       color: Pallete.gradient2,
                        //       borderRadius: BorderRadius.circular(5),
                        //     ),
                        //     child: Text(
                        //       'Show',
                        //       style: TextStyle(
                        //         color: Pallete.whiteColor,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        GradientButton(
                          text: 'Show',
                          fun: () async {
                            UniversityAndRelatedModel u =
                                await getUniversity(university.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UniversityPage(
                                  universityModel: u,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

addRowCard({
  required BuildContext context,
  required List<ScholarshipModel> scholarshipsMatrix,
  required List<UniversityModel> universityMatrix,
  required int index,
  bool isList = false,
  bool isRecommend = false,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      // Scholarship
      if (!isList &&
          scholarshipsMatrix.isNotEmpty &&
          min(4, (scholarshipsMatrix.length - index * 4).abs()) > 0)
        addCardScholarship(context, scholarshipsMatrix[index * 4 + 0]),
      if (!isList &&
          scholarshipsMatrix.isNotEmpty &&
          min(4, (scholarshipsMatrix.length - index * 4).abs()) > 1)
        addCardScholarship(context, scholarshipsMatrix[index * 4 + 1]),
      if (!isList &&
          scholarshipsMatrix.isNotEmpty &&
          min(4, (scholarshipsMatrix.length - index * 4).abs()) > 2)
        addCardScholarship(context, scholarshipsMatrix[index * 4 + 2]),
      if (!isList &&
          scholarshipsMatrix.isNotEmpty &&
          min(4, (scholarshipsMatrix.length - index * 4).abs()) > 3)
        addCardScholarship(context, scholarshipsMatrix[index * 4 + 3]),

      // My List
      if (isList && min(3, (scholarshipsMatrix.length - index * 3).abs()) > 0)
        addCardScholarship(context, scholarshipsMatrix[index * 3 + 0]),
      if (isList && min(3, (scholarshipsMatrix.length - index * 3).abs()) > 1)
        addCardScholarship(context, scholarshipsMatrix[index * 3 + 1]),
      if (isList && min(3, (scholarshipsMatrix.length - index * 3).abs()) > 2)
        addCardScholarship(context, scholarshipsMatrix[index * 3 + 2]),
      // if (isList && min(4, (scholarshipsMatrix.length - index * 4).abs()) > 3)
      //   addCardScholarship(context, scholarshipsMatrix[index * 4 + 3]),

      // Recommend
      if (isRecommend &&
          min(4, (scholarshipsMatrix.length - index * 4).abs()) > 0)
        addCardScholarship(context, scholarshipsMatrix[index * 4 + 0]),
      if (isRecommend &&
          min(4, (scholarshipsMatrix.length - index * 4).abs()) > 1)
        addCardScholarship(context, scholarshipsMatrix[index * 4 + 1]),
      if (isRecommend &&
          min(4, (scholarshipsMatrix.length - index * 4).abs()) > 2)
        addCardScholarship(context, scholarshipsMatrix[index * 4 + 2]),
      if (isRecommend &&
          min(4, (scholarshipsMatrix.length - index * 4).abs()) > 3)
        addCardScholarship(context, scholarshipsMatrix[index * 4 + 3]),

      // University
      if (universityMatrix.isNotEmpty &&
          min(4, (universityMatrix.length - index * 4).abs()) > 0)
        addCardUniversity(context, universityMatrix[index * 4 + 0]),
      if (universityMatrix.isNotEmpty &&
          min(4, (universityMatrix.length - index * 4).abs()) > 1)
        addCardUniversity(context, universityMatrix[index * 4 + 1]),
      if (universityMatrix.isNotEmpty &&
          min(4, (universityMatrix.length - index * 4).abs()) > 2)
        addCardUniversity(context, universityMatrix[index * 4 + 2]),
      if (universityMatrix.isNotEmpty &&
          min(4, (universityMatrix.length - index * 4).abs()) > 3)
        addCardUniversity(context, universityMatrix[index * 4 + 3]),
    ],
  );
}

addFormField({
  required context,
  required controller,
  required textInputType,
  required text,
  isPass = false,
  firstPassword = "",
  required validator,
  required onChanged,
  required onSubmitted,
  onPressedEyePassword = "",
  required IconData prefixIxon,
  bool readOnly = false,
}) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: 300,
    ),
    child: TextFormField(
      readOnly: readOnly,
      style: TextStyle(fontSize: textSize1),
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPass,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
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
        // labelStyle: TextStyle(color: Pallete.gradient1),
        hintText: 'Typing here',
        labelText: text,
        prefixIcon: Icon(
          prefixIxon,
          // color: Pallete.gradient1,
          color: Theme.of(context).colorScheme.primaryVariant,
        ),
        suffixIcon: text.contains("Password") && controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  isPass ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: onPressedEyePassword,
              )
            : null,
      ),
    ),
  );
}

Future<String> getToken() async {
  var response = await http.post(
    Uri.parse('$localhost/auth/jwt/create/'),
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: {
      "username": usernameLocal,
      "password": passwordLocal,
    },
    encoding: Encoding.getByName("utf-8"),
  );
  var responseData = jsonDecode(response.body);
  return responseData['access'];
}

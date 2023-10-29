// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unused_import, avoid_print, prefer_const_literals_to_create_immutables, unused_local_variable, constant_identifier_names, camel_case_types, prefer_final_fields, unused_field, no_logic_in_create_state, deprecated_member_use

import 'dart:convert';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Loging/widgets/gradient_button.dart';
import 'package:frontend/components.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/scholarships/models/scholarship_model.dart';
import 'package:frontend/universities/model/university_model.dart';
import 'package:frontend/scholarships/scholarship_page.dart';
// import 'package:country_code_picker/country_code_picker.dart';
import '../consts.dart';
import '../sidebar/widget/navigation_drawer_widget.dart';
import 'package:http/http.dart' as http;
import 'scholarship_api.dart';

class Scholarships extends StatefulWidget {
  final Map<String, List<String>> forYou;
  final String major;
  final String location;
  const Scholarships({
    required this.forYou,
    required this.major,
    required this.location,
    super.key,
  });

  @override
  State<Scholarships> createState() => _ScholarshipsState(
        forYou: forYou,
        major: major,
        location: location,
      );
}

class _ScholarshipsState extends State<Scholarships> {
  int numberPage = 1;
  int _fullTime = 2;
  Map<String, String> filters = {
    'degree_level': '',
    'location': '',
    'universities': '',
    'study_type': '',
    'programs': '',
    'tuition_fees__gte': '',
    'tuition_fees__lte': '',
  };

  Map<String, String> backFilters = {
    'degrees': 'degree_level',
    'country': 'location',
    'university': 'universities',
    'studyType': 'study_type',
    'specialization': 'programs',
    'feesGT': 'tuition_fees__gte',
    'feesLT': 'tuition_fees__lte',
  };

  Map<String, List<String>> forYou;
  String major;
  String location;
  _ScholarshipsState({
    required this.forYou,
    required this.major,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: addAppBar(context, 'Scholarships', false),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Column(
            children: [
              if (forYou.isNotEmpty | major.isNotEmpty | location.isNotEmpty)
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Icon(
                        forYou.isNotEmpty
                            ? Icons.favorite
                            : major.isNotEmpty
                                ? Icons.menu_book
                                : Icons.location_on,
                        // color: Pallete.backgroundColor,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 5),
                      Text(
                        forYou.isNotEmpty
                            ? 'Recommended For You'
                            : major.isNotEmpty
                                ? major
                                : location,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          // color: Pallete.gradient1,
                          color: Theme.of(context).colorScheme.primaryVariant,
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          setState(() {
                            major = '';
                            location = '';
                            forYou = {};
                          });
                        },
                        child: Icon(Icons.cancel, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              if (forYou.isNotEmpty | major.isNotEmpty | location.isNotEmpty)
                SizedBox(height: 25),
              Expanded(
                child: FutureBuilder(
                  // future: getAllScholarships(numberPage),
                  future: forYou.isNotEmpty
                      ? getRecommendation(
                          location_id: forYou['country'],
                          program_id: forYou['specialization'],
                          degree_level: forYou['degrees'],
                          study_type: forYou['study_type'],
                          scores_citations: forYou['preferences_score']!
                              .contains('Scores Citations'),
                          scores_teaching: forYou['preferences_score']!
                              .contains('Scores Teaching'),
                          scores_overall: forYou['preferences_score']!
                              .contains('Scores Overall'),
                          scores_research: forYou['preferences_score']!
                              .contains('Scores Research'),
                          scores_industry_income: forYou['preferences_score']!
                              .contains('Scores Industry Income'),
                          scores_international_outlook:
                              forYou['preferences_score']!
                                  .contains('Scores International Outlook'),
                        )
                      : major != ''
                          ? getMajorScholarships(major, numberPage)
                          : location != ''
                              ? getLocationScholarships(location, numberPage)
                              : getAllScholarships(numberPage),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Center(child: Text('No scholarships found!'));
                      }
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 50),
                        itemBuilder: (context, index) => addRowCard(
                          context: context,
                          scholarshipsMatrix: snapshot.data!,
                          universityMatrix: [],
                          index: index,
                        ),
                        itemCount: (snapshot.data!.length / 4).ceil(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              if (forYou.isEmpty)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (numberPage > 1) {
                              numberPage -= 1;
                            }
                          });
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (numberPage < numberOfScholarshipsPage) {
                              numberPage += 1;
                            }
                          });
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  addCheckbox({required value, required onChanged}) {
    return Checkbox(
      checkColor: Colors.white,
      // activeColor: Pallete.gradient1,
      activeColor: Theme.of(context).colorScheme.primaryVariant,
      value: value,
      onChanged: onChanged,
    );
  }
}

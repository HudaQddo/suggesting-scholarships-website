// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers, curly_braces_in_flow_control_structures, unused_import, no_logic_in_create_state, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:frontend/components.dart';
import 'package:frontend/consts.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/scholarships/models/scholarship_and_related_model.dart';
import 'package:frontend/scholarships/models/scholarship_model.dart';
import 'package:frontend/scholarships/scholarships.dart';
import 'package:frontend/universities/model/location_model.dart';
import 'package:frontend/universities/model/university_and_related_model.dart';
import 'package:frontend/universities/model/university_model.dart';
import 'package:frontend/universities/universities.dart';
import '../sidebar/widget/navigation_drawer_widget.dart';
import 'package:url_launcher/link.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ScholarshipPage extends StatefulWidget {
  final ScholarshipAndRelatedModel scholarshipModel;
  const ScholarshipPage({required this.scholarshipModel, super.key});

  @override
  State<ScholarshipPage> createState() =>
      _ScholarshipPageState(model: scholarshipModel);
}

class _ScholarshipPageState extends State<ScholarshipPage> {
  ScholarshipAndRelatedModel model;
  _ScholarshipPageState({required this.model});

  Map<String, String> titles = {
    'image': 'Image',
    'name': 'University Name',
    'location': 'Location',
    'description': 'Description',
    'website': 'Website Link',
    'rank': 'Rank',
  };
  bool underLineLocation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: addAppBar(context, 'Scholarship Page', true),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo & Name
                Stack(
                  children: [
                    Image.network(
                      'asset/backgrounds/background7.png',
                      scale: 0.7,
                      // color: Pallete.backgroundColor,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 75 , vertical: 50),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              model.scholarshipModel.name,
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 255, 17, 0),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scholarships(
                                              forYou: {},
                                              major: '',
                                              location: model
                                                  .scholarshipModel.location,
                                            )),
                                  );
                                },
                                onHover: (value) {
                                  setState(() {
                                    underLineLocation = value;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: underLineLocation
                                        ? Border(
                                            bottom: BorderSide(
                                              width: 1.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        : null,
                                  ),
                                  child: Text(
                                    model.scholarshipModel.location,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // University
                                addInnerTitle('University'),
                                SizedBox(height: 15),
                                Text(model.scholarshipModel.universities,
                                    style: TextStyle(fontSize: 17)),
                                SizedBox(height: 25),

                                // Deadline
                                addInnerTitle('Deadline'),
                                SizedBox(height: 15),
                                Text(model.scholarshipModel.deadline,
                                    style: TextStyle(fontSize: 17)),
                                SizedBox(height: 25),

                                // Tuition Fees
                                addInnerTitle('Tuition Fees'),
                                SizedBox(height: 15),
                                Text(model.scholarshipModel.fees,
                                    style: TextStyle(fontSize: 17)),
                                SizedBox(height: 25),

                                // Study Type
                                addInnerTitle('Study Type'),
                                SizedBox(height: 15),
                                Text(model.scholarshipModel.studyType,
                                    style: TextStyle(fontSize: 17)),
                                SizedBox(height: 25),

                                // Degree Level
                                addInnerTitle('Degree Level'),
                                SizedBox(height: 15),
                                Text(model.scholarshipModel.degreeLevel,
                                    style: TextStyle(fontSize: 17)),
                                SizedBox(height: 25),

                                // Scholarships Awarded
                                addInnerTitle('Scholarships Awarded'),
                                SizedBox(height: 15),
                                Text(model.scholarshipModel.numberOfAwards,
                                    style: TextStyle(fontSize: 17)),
                                SizedBox(height: 25),

                                // Citizenship Requirements
                                addInnerTitle('Citizenship Requirements'),
                                SizedBox(height: 15),
                                Text(model.scholarshipModel.requirements,
                                    style: TextStyle(fontSize: 17)),
                                SizedBox(height: 25),

                                // Eligibility
                                addInnerTitle('Eligibility'),
                                SizedBox(height: 15),
                                Text(model.scholarshipModel.eligibility,
                                    style: TextStyle(fontSize: 17)),
                                SizedBox(height: 25),
                              ],
                            ),
                          ),
                          SizedBox(width: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addInnerTitle('Related Scholarships'),
                              SizedBox(height: 25),
                              addCardScholarship(context,
                                  model.relatedScholarship.scholarships[0]),
                              addCardScholarship(context,
                                  model.relatedScholarship.scholarships[1]),
                              addCardScholarship(context,
                                  model.relatedScholarship.scholarships[2]),
                            ],
                          ),
                        ],
                      ),

                      // Major
                      addInnerTitle('Majors'),
                      SizedBox(height: 15),
                      Container(
                        height: 75,
                        child: model.scholarshipModel.major.isNotEmpty
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => addMajorCard(
                                    model.scholarshipModel.major[index]),
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 10),
                                itemCount: model.scholarshipModel.major.length,
                              )
                            : Text('No majors!'),
                      ),

                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addInnerTitle(text) {
    return Container(
      child: Text(
        '$text:',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: Theme.of(context).colorScheme.primaryVariant,
        ),
      ),
    );
  }

  Widget addMajorCard(name) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Scholarships(forYou: {}, major: name, location: ''),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: Text(name)),
      ),
    );
  }
}

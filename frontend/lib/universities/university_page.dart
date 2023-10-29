// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers, curly_braces_in_flow_control_structures, unused_import, no_logic_in_create_state, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:frontend/components.dart';
import 'package:frontend/consts.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/universities/model/location_model.dart';
import 'package:frontend/universities/model/university_and_related_model.dart';
import 'package:frontend/universities/universities.dart';
import '../sidebar/widget/navigation_drawer_widget.dart';
import 'model/university_model.dart';
import 'package:url_launcher/link.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UniversityPage extends StatefulWidget {
  final UniversityAndRelatedModel universityModel;
  const UniversityPage({required this.universityModel, super.key});

  @override
  State<UniversityPage> createState() =>
      _UniversityPageState(model: universityModel);
}

class _UniversityPageState extends State<UniversityPage> {
  UniversityAndRelatedModel model;
  _UniversityPageState({required this.model});

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
      appBar: addAppBar(context, 'University Page', true),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 0),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Image.network(
                            'asset/${model.universityModel.logo.replaceRange(0, 6, '')}',
                            width: 130,
                            height: 130,
                          ),
                          SizedBox(width: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.universityModel.name,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
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
                                          builder: (context) => Universities(
                                              major: '',
                                              location: model
                                                  .universityModel.location),
                                        ),
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
                                        model.universityModel.location,
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
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 100, vertical: 0),
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
                                // Website
                                addInnerTitle('Website'),
                                Link(
                                  uri: Uri.parse(model.universityModel.website),
                                  builder: (context, followLink) {
                                    return TextButton(
                                      onPressed: followLink,
                                      child: Text(model.universityModel.website,
                                          style: TextStyle(fontSize: 17)),
                                    );
                                  },
                                ),
                                SizedBox(height: 25),
                                // Description
                                addInnerTitle('Desciption'),
                                SizedBox(height: 15),
                                Text(model.universityModel.description,
                                    style: TextStyle(fontSize: 17)),
                                SizedBox(height: 25),
                                // Ranking & Number Of FTE Students
                                Row(
                                  children: [
                                    // Ranking
                                    Expanded(
                                      child: Container(
                                        height: 250,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            addInnerTitle('Ranking'),
                                            SizedBox(height: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: addListRank(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Number Of FTE Students
                                    Expanded(
                                      child: Container(
                                        height: 250,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            addInnerTitle(
                                                'Number of FTE Students'),
                                            SizedBox(height: 70),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                model.universityModel
                                                    .numberOfFTEStudents
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                  // color:
                                                  //     Pallete.backgroundColor,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),
                                // (F/M) Percent & International Students Percent
                                Row(
                                  children: [
                                    // Perccent of International Students
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          addInnerTitle(
                                              'Percentage of International Students'),
                                          SizedBox(height: 15),
                                          Container(
                                            alignment: Alignment.center,
                                            child: CircularPercentIndicator(
                                              radius: 100.0,
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: 15.0,
                                              percent: model.universityModel
                                                  .percentageOfInternationalStudents,
                                              center: Text(
                                                '${model.universityModel.percentageOfInternationalStudents * 100}%',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              circularStrokeCap:
                                                  CircularStrokeCap.butt,
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                              // progressColor: Pallete.borderColor,
                                              progressColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Female & Male Percent
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          addInnerTitle(
                                              'The Percent of Female to Male'),
                                          SizedBox(height: 15),
                                          Container(
                                            alignment: Alignment.center,
                                            child: CircularPercentIndicator(
                                              radius: 100.0,
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: 15.0,
                                              percent: model.universityModel
                                                      .percentOfFemale /
                                                  100,
                                              center: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 20,
                                                          height: 20,
                                                          // color: Color.fromARGB(255, 249, 100, 149),
                                                          // color:
                                                          //     Pallete.gradient2,
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .secondaryVariant,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Icon(Icons.female),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          '${model.universityModel.percentOfFemale}%',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Container(
                                                    width: 100,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 20,
                                                          height: 20,
                                                          // color: Pallete
                                                          //     .backgroundColor,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Icon(Icons.male),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          '${100 - model.universityModel.percentOfFemale}%',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              circularStrokeCap:
                                                  CircularStrokeCap.butt,
                                              // backgroundColor:
                                              //     Pallete.backgroundColor,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              // progressColor: Pallete.gradient2,
                                              progressColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondaryVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25),
                              ],
                            ),
                          ),
                          SizedBox(width: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addInnerTitle('Related Universities'),
                              SizedBox(height: 25),
                              addCardUniversity(context,
                                  model.relatedUniversity.universities[0]),
                              addCardUniversity(context,
                                  model.relatedUniversity.universities[1]),
                              addCardUniversity(context,
                                  model.relatedUniversity.universities[2]),
                            ],
                          ),
                        ],
                      ),
                      // Major
                      addInnerTitle('Majors'),
                      SizedBox(height: 15),
                      Container(
                        height: 75,
                        child: model.universityModel.majors.isNotEmpty
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => addMajorCard(
                                    model.universityModel.majors[index]),
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 10),
                                itemCount: model.universityModel.majors.length,
                              )
                            : Text('No majors!'),
                      ),
                      SizedBox(height: 25),
                      // Scolarships
                      addInnerTitle('Scholarships'),
                      SizedBox(height: 15),
                      Container(
                        height: model.universityModel.scholarships.isNotEmpty
                            ? 450
                            : 50,
                        child: model.universityModel.scholarships.isNotEmpty
                            ? ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    addCardScholarship(
                                        context,
                                        model.universityModel
                                            .scholarships[index]),
                                separatorBuilder: ((context, index) =>
                                    SizedBox(width: 15)),
                                itemCount:
                                    model.universityModel.scholarships.length,
                              )
                            : Text(
                                'This university is not currently offering scholarships.',
                                style: TextStyle(fontSize: 17),
                              ),
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
      width: 250,
      child: Text(
        '$text:',
        // maxLines: 2,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          // color: Pallete.gradient1,
          color: Theme.of(context).colorScheme.primaryVariant,
        ),
      ),
    );
  }

  List<Widget> addListRank() {
    Map<String, double> listOfRank = {
      'Overall': model.universityModel.scoreOverall,
      'Teaching': model.universityModel.scoreTeaching,
      'Reseach': model.universityModel.scoreReseach,
      'Citations': model.universityModel.scoreCitations,
      'Industry Income': model.universityModel.scoreIndustryIncome,
      'International Outlook': model.universityModel.scoreInternationalOutlook,
    };
    List<Widget> l = [];

    for (String k in listOfRank.keys) {
      Widget w = Row(
        children: [
          Container(
            width: 150,
            alignment: Alignment.center,
            child: Text(k),
          ),
          Container(
            width: 200 * listOfRank[k]! / 100,
            height: 15,
            // color: Pallete.gradient2,
            color: Theme.of(context).colorScheme.secondaryVariant,
          ),
          SizedBox(width: 5),
          Text(listOfRank[k].toString())
        ],
      );
      l.add(w);
      l.add(SizedBox(height: 15));
    }
    l.removeAt(l.length - 1);
    return l;
  }

  Widget addMajorCard(name) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Universities(major: name, location: ''),
          ),
        );
      },
      child: Container(
        // constraints: BoxConstraints(
        //   minWidth: 75,
        // ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          // color: Pallete.backgroundColor.withOpacity(0.3),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: Text(name)),
      ),
    );
  }
}

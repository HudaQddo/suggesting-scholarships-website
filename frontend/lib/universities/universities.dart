// ignore_for_file: prefer_const_constructors, unused_import, prefer_interpolation_to_compose_strings, avoid_print, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, no_logic_in_create_state, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/components.dart';
import 'package:frontend/consts.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/sidebar/widget/navigation_drawer_widget.dart';
import 'model/location_model.dart';
import 'model/university_model.dart';
import 'package:http/http.dart' as http;
import '../scholarships/scholarship_api.dart';
import 'university_api.dart';

class Universities extends StatefulWidget {
  final String major;
  final String location;
  const Universities({required this.major, required this.location, super.key});

  @override
  State<Universities> createState() =>
      _UniversitiesState(major: major, location: location);
}

class _UniversitiesState extends State<Universities> {
  int numberPage = 1;

  String major;
  String location;
  _UniversitiesState({required this.major, required this.location});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: addAppBar(context, 'Universities', false),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 30, right: 30),
          child: Column(
            children: [
              if (major.isNotEmpty | location.isNotEmpty)
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Icon(
                        major.isNotEmpty ? Icons.menu_book : Icons.location_on,
                        // color: Pallete.backgroundColor,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 5),
                      Text(
                        major.isNotEmpty ? major : location,
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
                          });
                        },
                        child: Icon(Icons.cancel, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              if (major.isNotEmpty | location.isNotEmpty) SizedBox(height: 25),
              Expanded(
                child: FutureBuilder(
                  future: major != ''
                      ? getMajorUniversities(major, numberPage)
                      : location != ''
                          ? getLocationUniversities(location, numberPage)
                          : getAllUniversities(numberPage),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 50),
                        itemBuilder: (context, index) => addRowCard(
                          context: context,
                          scholarshipsMatrix: [],
                          universityMatrix: snapshot.data!,
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
                          if (numberPage < numberOfUniversitiesPage) {
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
}

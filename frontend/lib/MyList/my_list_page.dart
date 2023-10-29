// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, implementation_imports, unnecessary_import, unused_local_variable, avoid_print, unused_import, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:frontend/Loging/widgets/gradient_button.dart';
import 'package:frontend/MyList/my_list_provider.dart';
import 'package:frontend/components.dart';
import 'package:frontend/sidebar/widget/navigation_drawer_widget.dart';
import '../consts.dart';
import '../pallete.dart';
import '../universities/model/location_model.dart';
import '../scholarships/models/scholarship_model.dart';
import '../universities/model/university_model.dart';
import 'package:http/http.dart' as http;

import 'my_list_api.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  bool underLineLocation = false;

  @override
  Widget build(BuildContext context) {
    setProvider(context);
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: addAppBar(context, 'My List', false),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(25),
          child: FutureBuilder<List<ScholarshipModel>>(
            future: getBucket(),
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as List<ScholarshipModel>;
                if (data.isEmpty) {
                  return Center(
                    child: Container(child: Text('My List is Empty!!')),
                  );
                }
                return Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(25),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.numbers,
                                color: Theme.of(context).colorScheme.background,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Number of Scholarships:',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            '      ${data.length}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.background,
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () async {
                                  await clearAllBucket();
                                  setState(() {});
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
                                    'Delete All',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 50),
                          itemBuilder: (context, index) => addRowCard(
                            context: context,
                            scholarshipsMatrix: data,
                            universityMatrix: [],
                            index: index,
                            isList: true,
                          ),
                          itemCount: (data.length / 3).ceil(),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  addRow(scholarshipsModels, index) {
    if (index == 0) {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.network(
            'asset/backgrounds/background4.png',
            fit: BoxFit.fill,
            // color: Pallete.borderColor,
            color: Theme.of(context).colorScheme.secondary,
            width: MediaQuery.of(context).size.width,
            height: 300,
          ),
          Text(
            'My List'.toUpperCase(),
            style: TextStyle(
              // color: Pallete.whiteColor,
              color: Theme.of(context).colorScheme.background,
              shadows: [
                Shadow(
                  offset: Offset(10.0, 10.0),
                  blurRadius: 3.0,
                  // color: Pallete.backgroundColor,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
              fontSize: (MediaQuery.of(context).size.width / 22),
            ),
          )
        ],
      );
    } else {
      return Container(
        padding: EdgeInsets.all(30),
        child: addRowCard(
          context: context,
          scholarshipsMatrix: scholarshipsModels,
          universityMatrix: [],
          index: index,
          isList: true,
        ),
      );
    }
  }
}

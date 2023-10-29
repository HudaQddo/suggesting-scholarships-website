// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, unused_import, avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/scholarships/models/scholarship_and_related_model.dart';
import 'package:provider/provider.dart';
import 'package:frontend/Loging/completeInformation.dart';
import 'package:frontend/Loging/signup_screen.dart';
import 'package:frontend/MyList/my_list_api.dart';
import 'package:frontend/MyList/my_list_page.dart';
import 'package:frontend/MyList/my_list_provider.dart';
import 'package:frontend/Personal/profile_page.dart';
import 'package:frontend/Themes/dark_theme.dart';
import 'package:frontend/Themes/light_theme.dart';
import 'package:frontend/consts.dart';
import 'package:frontend/main_page.dart';
import 'package:frontend/scholarships/models/scholarship_model.dart';
import 'package:frontend/scholarships/recommendation_form_page.dart';
import 'package:frontend/scholarships/scholarship_api.dart';
import 'package:frontend/scholarships/scholarship_page.dart';
import 'package:frontend/scholarships/scholarships.dart';
import 'package:frontend/universities/universities.dart';
import 'package:frontend/universities/university_page.dart';
import 'Loging/login_screen.dart';
import 'components.dart';
import 'pallete.dart';
import 'sidebar/provider/navigation_provider.dart';
import 'sidebar/widget/navigation_drawer_widget.dart';

import 'package:google_fonts/google_fonts.dart';

import 'universities/university_api.dart';

class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}

Future main() async {
  setToken();
  await Future.delayed(const Duration(seconds: 1));
  await getAllUniversities(1);
  await getBucket();
  await getScholarshipsLocation();
  await getScholarshipsMajors();
  await getScholarshipsDegrees();
  await getScholarshipsUniversities();

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => MyListProvider()))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: websiteTitle,
        scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.light(
            background: Pallete.whiteColor,
            primary: Pallete.backgroundColor,
            secondary: Pallete.borderColor,
            primaryVariant: Pallete.gradient1,
            secondaryVariant: Pallete.gradient2,
          ),
          textTheme: GoogleFonts.ptSansCaptionTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        // darkTheme: darkTheme,
        // themeMode: colorMode == 'light' ? ThemeMode.light : ThemeMode.dark,
        // home: LoginScreen(),
        home: Scaffold(
          body: FutureBuilder(
            // future: getAllScholarships(numberPage),
            future: getScholarship(134),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ScholarshipAndRelatedModel model =
                    snapshot.data as ScholarshipAndRelatedModel;
                return Container(
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: 75, vertical: 50),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                                                builder: (context) =>
                                                    Scholarships(
                                                      forYou: {},
                                                      major: '',
                                                      location: model
                                                          .scholarshipModel
                                                          .location,
                                                    )),
                                          );
                                        },
                                        onHover: (value) {
                                          // setState(() {
                                          //   underLineLocation = value;
                                          // });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              // border: underLineLocation
                                              //     ? Border(
                                              //         bottom: BorderSide(
                                              //           width: 1.0,
                                              //           color: Colors.white,
                                              //         ),
                                              //       )
                                              //     : null,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // University
                                        addInnerTitle(context, 'University'),
                                        SizedBox(height: 15),
                                        Text(
                                            model.scholarshipModel.universities,
                                            style: TextStyle(fontSize: 17)),
                                        SizedBox(height: 25),

                                        // Deadline
                                        addInnerTitle(context, 'Deadline'),
                                        SizedBox(height: 15),
                                        Text(model.scholarshipModel.deadline,
                                            style: TextStyle(fontSize: 17)),
                                        SizedBox(height: 25),

                                        // Tuition Fees
                                        addInnerTitle(context, 'Tuition Fees'),
                                        SizedBox(height: 15),
                                        Text(model.scholarshipModel.fees,
                                            style: TextStyle(fontSize: 17)),
                                        SizedBox(height: 25),

                                        // Study Type
                                        addInnerTitle(context, 'Study Type'),
                                        SizedBox(height: 15),
                                        Text(model.scholarshipModel.studyType,
                                            style: TextStyle(fontSize: 17)),
                                        SizedBox(height: 25),

                                        // Degree Level
                                        addInnerTitle(context, 'Degree Level'),
                                        SizedBox(height: 15),
                                        Text(model.scholarshipModel.degreeLevel,
                                            style: TextStyle(fontSize: 17)),
                                        SizedBox(height: 25),

                                        // Scholarships Awarded
                                        addInnerTitle(
                                            context, 'Scholarships Awarded'),
                                        SizedBox(height: 15),
                                        Text(
                                            model.scholarshipModel
                                                .numberOfAwards,
                                            style: TextStyle(fontSize: 17)),
                                        SizedBox(height: 25),

                                        // Citizenship Requirements
                                        addInnerTitle(context,
                                            'Citizenship Requirements'),
                                        SizedBox(height: 15),
                                        Text(
                                            model.scholarshipModel.requirements,
                                            style: TextStyle(fontSize: 17)),
                                        SizedBox(height: 25),

                                        // Eligibility
                                        addInnerTitle(context, 'Eligibility'),
                                        SizedBox(height: 15),
                                        Text(model.scholarshipModel.eligibility,
                                            style: TextStyle(fontSize: 17)),
                                        SizedBox(height: 25),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 50),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      addInnerTitle(
                                          context, 'Related Scholarships'),
                                      SizedBox(height: 25),
                                      addCardScholarship(
                                          context,
                                          model.relatedScholarship
                                              .scholarships[0]),
                                      addCardScholarship(
                                          context,
                                          model.relatedScholarship
                                              .scholarships[1]),
                                      addCardScholarship(
                                          context,
                                          model.relatedScholarship
                                              .scholarships[2]),
                                    ],
                                  ),
                                ],
                              ),

                              // Major
                              addInnerTitle(context, 'Majors'),
                              SizedBox(height: 15),
                              Container(
                                height: 75,
                                child: model.scholarshipModel.major.isNotEmpty
                                    ? ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            addMajorCard(
                                                context,
                                                model.scholarshipModel
                                                    .major[index]),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(width: 10),
                                        itemCount:
                                            model.scholarshipModel.major.length,
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

  Widget addInnerTitle(context, text) {
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

  Widget addMajorCard(context, name) {
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

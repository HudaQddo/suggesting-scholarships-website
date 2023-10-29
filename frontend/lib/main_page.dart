// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:frontend/Loging/widgets/gradient_button.dart';
import 'package:frontend/components.dart';
import 'package:frontend/sidebar/widget/navigation_drawer_widget.dart';

import 'scholarships/recommendation_form_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: addAppBar(context, 'Home', false),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.network(
                      'asset/backgrounds/background1.png',
                      fit: BoxFit.fill,
                      // color: Pallete.borderColor,
                      color: Theme.of(context).colorScheme.primary,
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Welcome to',
                              style: TextStyle(
                                fontSize: 50,
                                // color: Pallete.whiteColor,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                            Text(
                              'our website,',
                              style: TextStyle(
                                fontSize: 70,
                                // color: Pallete.gradient2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryVariant,
                              ),
                            ),
                            Text(
                              'we hope you like it.',
                              style: TextStyle(
                                fontSize: 50,
                                // color: Pallete.whiteColor,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 100),
                        Image.network('asset/images/person1.png'),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 50),
                          Image.network(
                            'asset/images/our_team.gif',
                            width: 450,
                          ),
                          SizedBox(width: 100),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'WHO ARE WE?',
                                  style: TextStyle(
                                    fontSize: 45,
                                    // color: Pallete.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'We are your guide to finding the right scholarship for you in an easy and effective way.',
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 25,
                                    // color: Pallete.whiteColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 50),
                        ],
                      ),
                      SizedBox(height: 150),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Why Choose Us?',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        'asset/images/universityIcon.png',
                                        width: 100,
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        '+200 Universities',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Choose from +200 universities.',
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        'asset/images/giftIcon.png',
                                        width: 100,
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'It is for FREE',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'You\'ll never have to pay for anything with our service! It\'s completely for free without any hidden fees.',
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        'asset/images/easyIcon.png',
                                        width: 100,
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Smooth Process',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'We help you with an easy process that is fast and efficient.',
                                        maxLines: 3,
                                      ),
                                    ],
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
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Image.network(
                      'asset/backgrounds/background2.png',
                      fit: BoxFit.fill,
                      // color: Pallete.borderColor,
                      color: Theme.of(context).colorScheme.primary,
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Are you willing to study abroad?',
                              style: TextStyle(
                                fontSize: 45,
                                // color: Pallete.whiteColor,
                                color: Theme.of(context).colorScheme.background,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Fill in the form to help you find the most suitable scholarship for you.',
                              style: TextStyle(
                                fontSize: 25,
                                // color: Pallete.whiteColor,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 100,
                              height: 40,
                              child: GradientButton(
                                text: 'Form',
                                fun: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RecommendationFormPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 50)
                          ],
                        ),
                        SizedBox(width: 100),
                        Image.network('asset/images/person2.gif'),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

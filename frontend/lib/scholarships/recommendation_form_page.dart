// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use, unused_local_variable, iterable_contains_unrelated_type, prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Loging/widgets/gradient_button.dart';
import 'package:frontend/components.dart';
import '../consts.dart';
import '../sidebar/widget/navigation_drawer_widget.dart';
import 'scholarships.dart';

class RecommendationFormPage extends StatefulWidget {
  const RecommendationFormPage({super.key});

  @override
  State<RecommendationFormPage> createState() => _RecommendationFormPageState();
}

class _RecommendationFormPageState extends State<RecommendationFormPage> {
  Map<String, List<String>> mapFilter = {
    'degrees': scolarshipDegrees,
    'country': scolarshipLocations.keys.toList(),
    'university': scolarshipUniversities.keys.toList(),
    'specialization': scolarshipMajors.keys.toList(),
    'preferences_score': [
      'Scores Overall',
      'Scores Teaching',
      'Scores Research',
      'Scores Citations',
      'Scores Industry Income',
      'Scores International Outlook',
    ]
  };

  Map<String, List<String>> selectedValues = {
    'degrees': [],
    'country': [],
    'university': [],
    'specialization': [],
    'preferences_score': [],
    'study_type': [],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: addAppBar(context, 'Recommendation', false),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                  
                  // Specialization
                  addTitle('Specialization', Icons.tune),
                  SizedBox(height: 25),
                  addMultiselectDropdown('specialization'),
                  SizedBox(height: 25),
                  // Country
                  addTitle('Countries', Icons.location_on),
                  SizedBox(height: 25),
                  addMultiselectDropdown('country'),
                  SizedBox(height: 25),
                  // Scores
                  addTitle('I\'m interested in ...', Icons.rate_review),
                  SizedBox(height: 25),
                  addMultiselectDropdown('preferences_score'),
                  SizedBox(height: 25),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Degree Level
                  addTitle('Degree Level', Icons.turned_in),
                  SizedBox(height: 25),
                  addMultiselectDropdown('degrees'),
                  SizedBox(height: 25),
                  // Study Type
                  addTitle('Study Type', Icons.book),
                  SizedBox(height: 25),
                  Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        addCheckbox(
                          text: 'Full Time',
                          value: selectedValues['study_type']!
                              .contains('Full Time'),
                          onChanged: (v) {
                            setState(() {
                              if (selectedValues['study_type']!
                                  .contains('Full Time')) {
                                selectedValues['study_type'] = [];
                              } else {
                                selectedValues['study_type'] = ['Full Time'];
                              }
                            });
                          },
                        ),
                        addCheckbox(
                          text: 'Part Time',
                          value: selectedValues['study_type']!
                              .contains('Part Time'),
                          onChanged: (v) {
                            setState(() {
                              if (selectedValues['study_type']!
                                  .contains('Part Time')) {
                                selectedValues['study_type'] = [];
                              } else {
                                selectedValues['study_type'] = ['Part Time'];
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  // Button Recommend
                  Container(
                    // height: 40,
                    width: 300,
                    child: GradientButton(
                      text: 'Get Recommendations',
                      fun: () async {
                        // List<ScholarshipModel> s = await getRecommendation(
                        //   scores_citations: selectedValues['preferences_score']!
                        //       .contains('Scores Citations'),
                        //   scores_teaching: selectedValues['preferences_score']!
                        //       .contains('Scores Teaching'),
                        //   scores_overall: selectedValues['preferences_score']!
                        //       .contains('Scores Overall'),
                        //   scores_research: selectedValues['preferences_score']!
                        //       .contains('Scores Research'),
                        //   scores_industry_income:
                        //       selectedValues['preferences_score']!
                        //           .contains('Scores Industry Income'),
                        //   scores_international_outlook:
                        //       selectedValues['preferences_score']!
                        //           .contains('Scores International Outlook'),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scholarships(
                                forYou: selectedValues,
                                major: '',
                                location: ''),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'asset/images/recommend.gif',
                    width: min(MediaQuery.of(context).size.height,
                            MediaQuery.of(context).size.width) /
                        2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addTitle(text, icon) {
    return Row(
      children: [
        Icon(
          icon,
          // color: Pallete.gradient1,
          color: Theme.of(context).colorScheme.primaryVariant,
        ),
        SizedBox(width: 5),
        Text(text),
      ],
    );
  }

  Widget addCheckbox({required text, required value, required onChanged}) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          // activeColor: Pallete.gradient1,
          activeColor: Theme.of(context).colorScheme.primaryVariant,
          value: value,
          onChanged: onChanged,
        ),
        Text(text),
      ],
    );
  }

  Widget addMultiselectDropdown(String type) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryVariant,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text('Select Items'),
          items: mapFilter[type]!.map((item) {
            return DropdownMenuItem(
              value: item,
              enabled: false,
              child: StatefulBuilder(
                builder: (context, menuSetState) {
                  bool isSelected =
                      selectedValues[type]!.contains(item);
                  return InkWell(
                    onTap: () {
                      if (type == 'degrees') {
                        if (!isSelected) {
                          selectedValues[type]!.clear();
                        }
                      }
                      isSelected
                          ? selectedValues[type]!.remove(item)
                          : selectedValues[type]!.add(item);

                      setState(() {});
                      menuSetState(() {});
                    },
                    child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          if (isSelected)
                            Icon(Icons.check_box_outlined)
                          else
                            Icon(Icons.check_box_outline_blank),
                          SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList(),
          value:
              selectedValues[type]!.isEmpty ? null : selectedValues[type]!.last,
          onChanged: (value) {},
          selectedItemBuilder: (context) {
            return mapFilter[type]!.map(
              (item) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    selectedValues[type]!.join(', '),
                    style: TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                );
              },
            ).toList();
          },
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(left: 16, right: 8),
            height: 40,
            width: 140,
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}

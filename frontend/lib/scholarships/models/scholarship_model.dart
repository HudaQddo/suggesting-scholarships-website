// ignore_for_file: unused_import

import 'package:frontend/consts.dart';
import 'package:frontend/universities/model/university_model.dart';

class ScholarshipModel {
  int id;
  String name;
  // String description;
  String location;
  String deadline;
  String fees;
  String degreeLevel;
  String studyType;
  String numberOfAwards;
  String requirements;
  String eligibility;
  String image;
  String universities;
  List<String> major;
  bool inList;

  ScholarshipModel({
    required this.id,
    required this.name,
    // required this.description,
    required this.location,
    required this.deadline,
    required this.fees,
    required this.degreeLevel,
    required this.studyType,
    required this.numberOfAwards,
    required this.requirements,
    required this.eligibility,
    required this.image,
    required this.universities,
    required this.major,
    this.inList = false,
  });

  factory ScholarshipModel.fromJson(Map<String, dynamic> json) {
    List<String> programs = [];
    if (json['programs'] != null) {
      for (var p in json['programs']) {
        programs.add(p);
      }
    }
    return ScholarshipModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      location: json['location'] ?? "",
      deadline: json['deadline'] ?? "",
      fees: json['tuition_fees'] ?? "",
      degreeLevel: json['degree_level'] ?? "",
      studyType: json['study_type'] ?? "",
      numberOfAwards: json['scholarships_awarded'] ?? "",
      requirements: json['citizenship_requirements'] ?? "",
      eligibility: json['eligibility'] ?? "",
      image: 'asset/universities/image/${json['university']}.jpg',
      universities: json['university'] ?? "",
      major: programs,
      inList: provider.myList.contains(json['id']),
    );
  }
}

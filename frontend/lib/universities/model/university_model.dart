import 'package:frontend/scholarships/models/scholarship_model.dart';

class UniversityModel {
  int id;
  String name;
  String description;
  String location;
  int rank;
  String website;
  String image;
  List<ScholarshipModel> scholarships;
  String logo;
  List<String> majors;
  double scoreOverall;
  double scoreTeaching;
  double scoreReseach;
  double scoreCitations;
  double scoreIndustryIncome;
  double scoreInternationalOutlook;
  double percentOfFemale;
  double numberOfFTEStudents;
  double percentageOfInternationalStudents;

  UniversityModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.location,
    required this.rank,
    required this.website,
    required this.image,
    required this.scholarships,
    required this.logo,
    required this.majors,
    required this.scoreOverall,
    required this.scoreTeaching,
    required this.scoreReseach,
    required this.scoreCitations,
    required this.scoreIndustryIncome,
    required this.scoreInternationalOutlook,
    required this.percentOfFemale,
    required this.numberOfFTEStudents,
    required this.percentageOfInternationalStudents,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? "",
      location: json['location'] ?? "",
      rank: json['rank'] ?? 0,
      website: json['website'] ?? "",
      image: 'asset/universities/image/${json['name']}.jpg',
      scholarships: [],
      logo: json['logo'] ?? "",
      majors: json['programs'] ?? [],
      scoreOverall: json['scores_overall'] ?? 0,
      scoreTeaching: json['scores_teaching'] ?? 0,
      scoreReseach: json['scores_reseach'] ?? 0,
      scoreCitations: json['scores_citations'] ?? 0,
      scoreIndustryIncome: json['scores_industry_income'] ?? 0,
      scoreInternationalOutlook: json['scores_international_outlook'] ?? 0,
      percentOfFemale: json['student_ratio_of_females_to_males'] ?? 0,
      numberOfFTEStudents:
          json['number_of_full_time_equivalent_students'] ?? 0,
      percentageOfInternationalStudents: json['percentage_of_international_students'] ?? 0,
    );
  }
}

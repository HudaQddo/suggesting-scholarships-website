import 'dart:convert';

import 'package:frontend/scholarships/models/scholarship_model.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/universities/model/related_university.dart';
import '../consts.dart';
import 'model/university_and_related_model.dart';
import 'model/university_model.dart';

Future<List<UniversityModel>> getAllUniversities(int numberPage) async {
  String url = numberPage == 1
      ? '$localhost/project/universities/'
      : '$localhost/project/universities/?page=$numberPage';
  var response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    numberOfUniversitiesPage = body['count'] / 24;
    numberOfUniversitiesPage = numberOfUniversitiesPage.ceilToDouble();
    var responseData = body['results'];
    List<UniversityModel> universities = [];
    for (var item in responseData) {
      UniversityModel university = UniversityModel.fromJson(item);
      universities.add(university);
    }
    // setUniversity(universities);
    return universities;
  } else {
    throw Exception('Fail');
  }
}

Future<UniversityAndRelatedModel> getUniversity(int id) async {
  var response = await http.get(
    Uri.parse('$localhost/project/universities/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var item = jsonDecode(response.body);
    List<String> programs = [];
    for (String p in item['university']['programs']) {
      programs.add(p);
    }
    List<ScholarshipModel> scholarships = [];
    for (var sm in item['scholarships']) {
      scholarships.add(ScholarshipModel.fromJson(sm));
    }

    UniversityModel university = UniversityModel(
      id: id,
      name: item['university']['name'],
      description: item['university']['description'] ?? "",
      location: item['university']['location'] ?? "",
      rank: item['university']['rank'] ?? 0,
      website: item['university']['website'] ?? "",
      // image: item['image'],
      image: 'asset/images/university.jpg',
      scholarships: scholarships,
      logo: item['university']['logo'] ?? 'asset/images/university.jpg',
      majors: programs,
      scoreOverall: item['university']['scores_overall'] ?? 0,
      scoreTeaching: item['university']['scores_teaching'] ?? 0,
      scoreReseach: item['university']['scores_research'] ?? 0,
      scoreCitations: item['university']['scores_citations'] ?? 0,
      scoreIndustryIncome: item['university']['scores_industry_income'] ?? 0,
      scoreInternationalOutlook:
          item['university']['scores_international_outlook'] ?? 0,
      percentOfFemale: double.parse(item['university']
              ['student_ratio_of_females_to_males']
          .split(':')[0]),
      numberOfFTEStudents:
          item['university']['number_of_full_time_equivalent_students'] ?? 0,
      percentageOfInternationalStudents:
          item['university']['percentage_of_international_students'] ?? 0,
    );
    List<UniversityModel> related = [];
    for (var item in item['related_universities']) {
      UniversityModel u = UniversityModel.fromJson(item);
      related.add(u);
    }
    UniversityAndRelatedModel finalUniversity = UniversityAndRelatedModel(
        relatedUniversity: RelatedUniversity(universities: related),
        universityModel: university);
    return finalUniversity;
  } else {
    throw Exception('Fail');
  }
}

Future<List<UniversityModel>> getMajorUniversities(
    String major, int numberPage) async {
  String url =
      '$localhost/project/programs/$major/universities/?page=$numberPage';
  var response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    numberOfUniversitiesPage = body['count'] / 24;
    numberOfUniversitiesPage = numberOfUniversitiesPage.ceilToDouble();
    var responseData = body['results'];
    List<UniversityModel> universities = [];
    for (var item in responseData) {
      UniversityModel university = UniversityModel.fromJson(item);
      universities.add(university);
    }
    // setUniversity(universities);
    return universities;
  } else {
    throw Exception('Fail');
  }
}

Future<List<UniversityModel>> getLocationUniversities(
    String location, int numberPage) async {
  String url =
      '$localhost/project/location/$location/universities/?page=$numberPage';
  var response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    numberOfUniversitiesPage = body['count'] / 24;
    numberOfUniversitiesPage = numberOfUniversitiesPage.ceilToDouble();
    var responseData = body['results'];
    List<UniversityModel> universities = [];
    for (var item in responseData) {
      UniversityModel university = UniversityModel.fromJson(item);
      universities.add(university);
    }
    // setUniversity(universities);
    return universities;
  } else {
    throw Exception('Fail');
  }
}

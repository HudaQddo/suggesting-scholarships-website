// ignore_for_file: avoid_print, unused_import, non_constant_identifier_names

import 'dart:convert';
import 'package:frontend/MyList/my_list_provider.dart';
import 'package:frontend/Personal/profile_api.dart';
import 'package:frontend/scholarships/models/related_scolarship.dart';
import 'package:frontend/scholarships/models/scholarship_and_related_model.dart';
import '../MyList/my_list_api.dart';
import '../components.dart';
import '../consts.dart';
import 'models/scholarship_model.dart';
import 'package:http/http.dart' as http;
import '../universities/model/university_model.dart';

// Get All Scholarships
Future<List<ScholarshipModel>> getAllScholarships(int numberPage) async {
  var response = await http.get(
    Uri.parse('$localhost/project/scholarships/?page=$numberPage'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    numberOfScholarshipsPage = body['count'] / 24;
    numberOfScholarshipsPage = numberOfScholarshipsPage.ceilToDouble();
    List<ScholarshipModel> scholarships = [];
    var items = body['results'];
    for (var item in items) {
      ScholarshipModel s = ScholarshipModel(
        id: item['id'],
        name: item['name'] ?? "",
        // description: item['description'] ?? "",
        location: item['location'] ?? "",
        deadline: item['deadline'] ?? "",
        fees: item['tuition_fees'] ?? "",
        degreeLevel: item['degree_level'] ?? "",
        studyType: item['study_type'] ?? "",
        numberOfAwards: item['scholarships_awarded'] ?? "",
        requirements: item['citizenship_requirements'] ?? "",
        eligibility: item['eligibility'] ?? "",
        // image: 'asset/images/university.jpg',
        image: 'asset/universities/image/${item['university']}.jpg',
        universities: item['university'] ?? "",
        major: item['prgrams'] ?? [],
        inList: provider.myList.contains(item['id']),
      );
      scholarships.add(s);
    }
    return scholarships;
  } else {
    throw Exception('Fail');
  }
}

// Get Scholarship Information
Future<ScholarshipAndRelatedModel> getScholarship(int id) async {
  var response = await http.get(
    Uri.parse('$localhost/project/scholarships/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    var item = jsonDecode(response.body);
    ScholarshipModel scholarship =
        ScholarshipModel.fromJson(item['scholarship']);
    List<ScholarshipModel> related = [];
    for (var item in item['related_scholarships']) {
      ScholarshipModel s = ScholarshipModel.fromJson(item);
      related.add(s);
    }
    ScholarshipAndRelatedModel finalUniversity = ScholarshipAndRelatedModel(
      relatedScholarship: RelatedScholarship(scholarships: related),
      scholarshipModel: scholarship,
    );
    return finalUniversity;
  } else {
    throw Exception('Fail');
  }
}

// Get Recommendation
Future<List<ScholarshipModel>> getRecommendation({
  location_id,
  program_id,
  degree_level,
  study_type,
  scores_overall,
  scores_teaching,
  scores_research,
  scores_citations,
  scores_industry_income,
  scores_international_outlook,
}) async {
  int id = (await getProfile()).id;
  var token = await getToken();
  List<int> countriesID = [];
  for (String c in location_id) {
    countriesID.add(scolarshipLocations[c]!);
  }
  // List<int> universitiesID = [];
  // for (String c in university_id) {
  //   universitiesID.add(scolarshipUniversities[c]!);
  // }
  List<int> majorsID = [];
  for (String c in program_id) {
    majorsID.add(scolarshipMajors[c]!);
  }

  var response = await http.post(
    Uri.parse('$localhost/project/recommend-scholarships/'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    },
    body: jsonEncode({
      "user_id": id,
      "location_id": countriesID.isNotEmpty ? countriesID : null,
      "program_id": majorsID.isNotEmpty ? majorsID : null,
      "degree_level": degree_level.isNotEmpty ? degree_level[0] : null,
      "study_type": study_type.isNotEmpty
          ? study_type[0] == 'Full Time'
              ? 'full-time'
              : 'part-time'
          : null,
      "scores_overall": scores_overall == true ? 'scores_overall' : null,
      "scores_teaching": scores_teaching == true ? 'scores_teaching' : null,
      "scores_research": scores_research == true ? 'scores_research' : null,
      "scores_citations": scores_citations == true ? 'scores_citations' : null,
      "scores_industry_income":
          scores_industry_income == true ? 'scores_industry_income' : null,
      "scores_international_outlook": scores_international_outlook == true
          ? 'scores_international_outlook'
          : null
    }),
  );

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    numberOfScholarshipsPage = numberOfScholarshipsPage.ceilToDouble();
    List<ScholarshipModel> scholarships = [];
    var items = body;
    for (var item in items) {
      ScholarshipModel s = ScholarshipModel(
        id: item['id'],
        name: item['name'] ?? "",
        location: item['location'] ?? "",
        deadline: item['deadline'] ?? "",
        fees: item['tuition_fees'] ?? "",
        degreeLevel: item['degree_level'] ?? "",
        studyType: item['study_type'] ?? "",
        numberOfAwards: item['scholarships_awarded'] ?? "",
        requirements: item['citizenship_requirements'] ?? "",
        eligibility: item['eligibility'] ?? "",
        image: 'asset/universities/image/${item['university']}.jpg',
        universities: item['university'] ?? "",
        major: item['prgrams'] ?? [],
        inList: provider.myList.contains(item['id']),
      );
      scholarships.add(s);
    }
    return scholarships;
  } else {
    throw Exception('Fail');
  }
}

// Filter Scholarship by Major
Future<List<ScholarshipModel>> getMajorScholarships(
    String major, int numberPage) async {
  String url =
      '$localhost/project/programs/$major/scholarships/?page=$numberPage';
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
    List<ScholarshipModel> scholarships = [];
    for (var item in responseData) {
      ScholarshipModel scholarship = ScholarshipModel.fromJson(item);
      scholarships.add(scholarship);
    }
    // setUniversity(universities);
    return scholarships;
  } else {
    throw Exception('Fail');
  }
}

// Filter Scholarship by Location
Future<List<ScholarshipModel>> getLocationScholarships(
    String location, int numberPage) async {
  String url =
      '$localhost/project/location/$location/scholarships/?page=$numberPage';
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
    List<ScholarshipModel> scholarships = [];
    for (var item in responseData) {
      ScholarshipModel scholarship = ScholarshipModel.fromJson(item);
      scholarships.add(scholarship);
    }
    // setUniversity(universities);
    return scholarships;
  } else {
    throw Exception('Fail');
  }
}

// Get Scholarships' Majors
Future<void> getScholarshipsMajors() async {
  String url = '$localhost/project/scholarships/programs/';
  var response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    // List<String> majors = [];
    scolarshipMajors = {};
    var items = jsonDecode(response.body);
    for (var item in items) {
      scolarshipMajors[item[1]] = item[0];
      // majors.add(item);
    }
    // scolarshipMajors += majors;
    return;
  } else {
    throw Exception('Fail');
  }
}

// Get Scholarships' Location
Future<void> getScholarshipsLocation() async {
  String url = '$localhost/project/scholarships/locations/';
  var response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    // List<String> countries = [];
    var items = jsonDecode(response.body);
    scolarshipLocations = {};
    for (var item in items) {
      scolarshipLocations[item[1]] = item[0];
      // countries.add(item);
    }
    // scolarshipLocations += countries;
    return;
  } else {
    throw Exception('Fail');
  }
}

// Get Scholarships' Degrees
Future<List<String>> getScholarshipsDegrees() async {
  String url = '$localhost/project/scholarships/degree-levels/';
  var response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    List<String> degrees = [];
    var items = jsonDecode(response.body);
    for (var item in items) {
      degrees.add(item);
    }
    scolarshipDegrees = [];
    scolarshipDegrees += degrees;
    return degrees;
  } else {
    throw Exception('Fail');
  }
}

// Get Scholarships' Universities
Future<void> getScholarshipsUniversities() async {
  String url = '$localhost/project/scholarships/universities/';
  var response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    // List<List<String>> universities = [];
    var items = jsonDecode(response.body);
    scolarshipUniversities = {};
    for (var item in items) {
      scolarshipUniversities[item[1]] = item[0];
      // universities.add(item);
    }
    // scolarshipUniversities += universities;
    return;
  } else {
    throw Exception('Fail');
  }
}

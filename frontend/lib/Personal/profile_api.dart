// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:frontend/Personal/Models/user_model.dart';
import 'package:http/http.dart' as http;

import '../components.dart';
import '../consts.dart';

Future<UserModel> getProfile() async {
  var token = await getToken();
  var response = await http.get(
    Uri.parse('$localhost/project/applicants/profile/'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    },
  );

  if (response.statusCode == 200) {
    var item = jsonDecode(response.body);

    UserModel user = UserModel(
      id: item['id'],
      username: item['username'],
      firstName: item['firstname'],
      lastName: item['lastname'],
      email: item['email_address'],
      gender: item['gender'],
      phoneNumber: item['phone_number'],
      nationality: item['nationality'],
      country: item['country'],
      birthdate: item['birth_date'],
      degreeLevel: item['degree_level'],
      major: item['major'],
      studyStatus: item['study_status'],
    );
    return user;
  } else {
    throw Exception('Fail');
  }
}

Future editProfile(UserModel userModel) async {
  List<String> date = userModel.birthdate.split('-');
  date[0] = date[0].padLeft(2, '0');
  date[1] = date[1].padLeft(2, '0');
  date[2] = date[2].padLeft(2, '0');
  userModel.birthdate = date.join('-');

  var token = await getToken();
  var response = await http.put(
    Uri.parse('$localhost/project/applicants/profile/edit/'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    },
    body: jsonEncode({
      "username": userModel.username,
      "email_address": userModel.email,
      "firstname": userModel.firstName,
      "lastname": userModel.lastName,
      "birth_date": userModel.birthdate,
      "gender": userModel.gender ,
      "country": userModel.country,
      "nationality": userModel.nationality,
      "phone_number": userModel.phoneNumber,
      "degree_level": userModel.degreeLevel,
      "major": userModel.major,
      "study_status": userModel.studyStatus,
    }),
  );
}

// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import '../components.dart';
import '../consts.dart';
import '../scholarships/models/scholarship_model.dart';
import 'package:http/http.dart' as http;

Future<List<ScholarshipModel>> getBucket() async {
  var response = await http.get(
    Uri.parse('$localhost/project/buckets/bucket/'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $tokenUser',
    },
  );
  var items = jsonDecode(response.body);

  if (response.statusCode == 200) {
    List<ScholarshipModel> scholarshipsModel = [];
    List<int> scholarships = [];
    for (var scholarship in items['scholarships']) {
      scholarships.add(scholarship['id']);
      ScholarshipModel ss = ScholarshipModel.fromJson(scholarship);
      ss.inList = true;
      scholarshipsModel.add(ss);
    }
    myListData = scholarshipsModel;
    provider.initialList(scholarships);

    return scholarshipsModel;
  } else {
    throw Exception('Fail');
  }
}

Future addToBucket(int id) async {
  var token = await getToken();
  var response = await http.get(
    Uri.parse('$localhost/project/buckets/bucket/add-scholarship/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    },
  );
  // idMyListData.add(id);
}

Future removeFromBucket(int id) async {
  var token = await getToken();
  var response = await http.get(
    Uri.parse('$localhost/project/buckets/bucket/remove-scholarship/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    },
  );
  // idMyListData.remove(id);
}

Future clearAllBucket() async {
  var token = await getToken();
  var response = await http.get(
    Uri.parse('$localhost/project/buckets/bucket/clear'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    },
  );
}

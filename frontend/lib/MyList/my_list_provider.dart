// ignore_for_file: prefer_final_fields, unused_import, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:frontend/MyList/my_list_api.dart';
import 'package:frontend/scholarships/models/scholarship_model.dart';
import '../universities/model/location_model.dart';
import '../universities/model/university_model.dart';

class MyListProvider extends ChangeNotifier {
  List<int> _myList = [];
  List<int> get myList => _myList;

  void initialList(List<int> scholarships) {
    _myList = scholarships;
  }

  void addToList(ScholarshipModel model) {
    _myList.add(model.id);
    addToBucket(model.id);
    notifyListeners();
  }

  void removeFromList(ScholarshipModel model) {
    _myList.remove(model.id);
    removeFromBucket(model.id);
    notifyListeners();
  }
}

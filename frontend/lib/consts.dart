import 'package:frontend/scholarships/scholarship_api.dart';
import 'package:provider/provider.dart';
import 'package:frontend/components.dart';
import 'MyList/my_list_provider.dart';
import 'scholarships/models/scholarship_model.dart';

String websiteTitle = 'Scholarships Website';

String localhost = 'http://127.0.0.1:8000';

String colorMode = 'light';
changeMode() {
  if (colorMode == 'light') {
    colorMode = 'dark';
  } else {
    colorMode = 'light';
  }
}

String usernameLocal = 'lana';
String passwordLocal = 'lana123456';

setUser(String user, String pass) {
  usernameLocal = user;
  passwordLocal = pass;
}

String tokenUser = "";
setToken() async {
  tokenUser = await getToken();
}

MyListProvider provider = MyListProvider();
setProvider(context) {
  provider = Provider.of<MyListProvider>(context, listen: false);
}

List<ScholarshipModel> myListData = [];
Map<String, int> scolarshipLocations = {};
Map<String, int> scolarshipMajors = {};
List<String> scolarshipDegrees = [];
Map<String, int> scolarshipUniversities = {};

double numberOfUniversitiesPage = 1;
double numberOfScholarshipsPage = 1;
double textSize1 = 14;
double textSize2 = 18;
double textSize3 = 20;

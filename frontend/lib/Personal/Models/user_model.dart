class UserModel {
  int id;
  String username;
  String firstName;
  String lastName;
  String email;
  String gender;
  // String address;
  String phoneNumber;
  String nationality;
  String country;
  String birthdate;
  // String image;
  String degreeLevel;
  String major;
  String studyStatus;

  UserModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    // this.address = '',
    required this.phoneNumber,
    required this.nationality,
    required this.country,
    required this.birthdate,
    // this.image = '',
    required this.degreeLevel,
    required this.major,
    required this.studyStatus,
  });
}

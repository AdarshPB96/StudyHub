class SignUpRequest {
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String email;
  final String country;
  final String state;
  final String city;
  final String studyingFor;
  final String schoolOrCollegeOrInsti;
  final String interests;
  final String password;

  final String profilePicUrl;

  SignUpRequest(this.firstName, this.lastName, this.dateOfBirth, this.email, this.country, this.state, this.city, this.studyingFor, this.schoolOrCollegeOrInsti, this.interests, this.password, this.profilePicUrl);

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'country': country,
      'state': state,
      'city': city,
      'studyingFor': studyingFor,
      'schoolOrCollegeOrInsti': schoolOrCollegeOrInsti,
      'interests': interests,
      'password': password,

      'profilePicUrl': profilePicUrl,
    };
  }
}

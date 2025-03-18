class UserBody {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;

  UserBody(this.firstName, this.lastName, this.email, this.uid);

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email
    };
  }
}

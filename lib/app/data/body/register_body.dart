// {
//     "name": "Nguyễn Thanh Minh",
//     "email": "ntminh16201.work@gmail.com",
//     "password": "123456"
// }
class RegisterBody {
  final String name;
  final String email;
  final String password;

  RegisterBody(this.name, this.email, this.password);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}

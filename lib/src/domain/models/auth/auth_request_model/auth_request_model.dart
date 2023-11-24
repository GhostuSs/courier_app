class AuthRequestModel {
  AuthRequestModel({required this.email, required this.password});
  final String email;
  final String password;

  Map<String, dynamic> toJson() => {
        'login': email,
        'password': password,
      };
}

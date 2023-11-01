class AuthResponseModel{
  AuthResponseModel({required this.status,required this.token});
  final String status;
  final String token;
  static AuthResponseModel fromJson({required Map<String,dynamic> json})=>AuthResponseModel(status: json['status'], token: json['token']);
}
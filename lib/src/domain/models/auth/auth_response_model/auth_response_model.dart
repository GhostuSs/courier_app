class AuthResponseModel {
  AuthResponseModel({required this.status, required this.token});
  final String status;
  final String token;
  static AuthResponseModel? fromJson({required Map<String, dynamic> json}){
    if(json.containsKey('status')&&json.containsKey('token'))
    return AuthResponseModel(status: json['status'], token: json['token']);
  }
}

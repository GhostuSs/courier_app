import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRequestModel{
  AuthRequestModel({required this.email,required this.password});
  final String email;
  final String password;

  Map<String,dynamic> toJson()=>{
    "login":email,
    "password":password,
    "token":dotenv.env['TOKEN']
  };
}
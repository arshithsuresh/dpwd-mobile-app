import 'dart:convert';

import 'package:dpwdapp/api/httpservice.dart';
import 'package:dpwdapp/model/userModel.dart';

class UserAPI{
  HttpService _httpService = HttpService();

  Future<User> loginUser({username,password}) async {
    
    final userData = {
      "username":username,
      "password":password
    };
    
    final result = await _httpService.postRequest(data: userData, endpoint: "/auth/login");
    if(result.statusCode == 200)
    {
      _httpService.addUserToken(result.data['accessToken']);      
      return User.fromJson(result.data);
    } 
    else
      return null;
  }
}
import 'package:dpwdapp/api/UserAPI.dart';
import 'package:dpwdapp/api/httpservice.dart';
import 'package:dpwdapp/constants/constants.dart';
import 'package:dpwdapp/model/userModel.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier{

  User curUser;
  UserAPI _userAPI = UserAPI();

  isGovtUser(){
    return curUser.organization == GOVT_ORG;
  }

  isPublicUser(){
    return curUser.organization == PUBLIC_ORG;
  }

  isContractorUser(){
    return curUser.organization == CONTRACTOR_ORG;
  }

  isVerifiedUser(){
    return curUser.verified == 1;
  }

  

  Future<bool> LogInUser({username, password}) async
  {
    User user = await _userAPI.loginUser(username: username, password: password);
    
    if(user == null)
    {
      print("Login Error");
      UserLoginError();
      return false;;
    }

    curUser = user;
    notifyListeners();
    return true;
    
  }

  void UserLoginError(){

    notifyListeners();
  }

}
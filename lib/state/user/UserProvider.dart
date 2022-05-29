import 'package:dpwdapp/api/UserAPI.dart';
import 'package:dpwdapp/api/httpservice.dart';
import 'package:dpwdapp/model/userModel.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier{

  User curUser;
  UserAPI _userAPI = UserAPI();

  Future<bool> LogInUser({username, password}) async
  {
    User user = await _userAPI.loginUser(username: username, password: password);
    if(user == null)
    {
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
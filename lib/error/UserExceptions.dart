
class InvalidUserException implements Exception{

  String error = "The user is invalid";
  InvalidUserException();

  @override
  String toString() {   
    return "USER EXCEPTION: ${this.error}";
  }
}

class AccessTokenExpired implements Exception{
  String error = "User token has Expired. Login Again";
  AccessTokenExpired();

  @override
  String toString() {   
    return "USER EXCEPTION: ${this.error}";
  }
}

class UserNotVerified implements Exception{
  String error = "User has not completed the verficiation process.";
  UserNotVerified();

  @override
  String toString() {   
    return "USER EXCEPTION: ${this.error}";
  }
}

class UnAuthorizedUser implements Exception{
  String error = "User is not authoized to perform this function!";
  UnAuthorizedUser();

  @override
  String toString() {   
    return "USER EXCEPTION: ${this.error}";
  }
}


class InvalidUserException implements Exception{

  String error = "The user is invalid";
  InvalidUserException(this.error);

  @override
  String toString() {   
    return "USER EXCEPTION: ${this.error}";
  }
}

class AccessTokenExpired implements Exception{
  String error = "User token has Expired. Login Again";
  AccessTokenExpired(this.error);

  @override
  String toString() {   
    return "USER EXCEPTION: ${this.error}";
  }
}

class UserNotVerified implements Exception{
  String error = "User has not completed the verficiation process.";
  UserNotVerified(this.error);

  @override
  String toString() {   
    return "USER EXCEPTION: ${this.error}";
  }
}

class UnAuthorizedUser implements Exception{
  String error = "User is not authoized to perform this function!";
  UnAuthorizedUser(this.error);

  @override
  String toString() {   
    return "USER EXCEPTION: ${this.error}";
  }
}
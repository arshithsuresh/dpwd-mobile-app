

class ProjectDoesNotExit implements Exception{

  String error = "Given project does not exit";
  ProjectDoesNotExit();

  @override
  String toString() {   
    return "PROJECT EXCEPTION: ${this.error}";
  }
}

class InvalidDataFormat implements Exception{

  String error = "Invalid data format";
  InvalidDataFormat();

  @override
  String toString() {   
    return "PROJECT EXCEPTION: ${this.error}";
  }
}


class ProjectExits implements Exception{

  String error = "Given project already exit";
  ProjectExits();

  @override
  String toString() {   
    return "PROJECT EXCEPTION: ${this.error}";
  }
}

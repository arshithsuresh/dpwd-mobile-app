import 'package:dpwdapp/api/ProjectAPI.dart';
import 'package:dpwdapp/model/projectModel.dart';
import 'package:flutter/foundation.dart';

class ProjectsProvider extends ChangeNotifier {
  List<Project> _projects;
  ProjectAPI _projectAPI = ProjectAPI();

  Future<List<Project>> initializeAllProjects() async {
    _projects = await _projectAPI.getAllProject();
    if (_projects != null) {
      notifyListeners();
      return _projects;
    }
    return null;
  }

  List<Project> getAllProjects() {
    if (_projects != null || _projects.length > 0) {
      return _projects;
    }

    return null;
  }

  
}

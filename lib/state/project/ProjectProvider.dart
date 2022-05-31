import 'dart:math';

import 'package:dpwdapp/api/ProjectAPI.dart';
import 'package:dpwdapp/error/UserExceptions.dart';
import 'package:dpwdapp/model/projectModel.dart';
import 'package:flutter/foundation.dart';
import 'package:dpwdapp/error/ProjectExceptions.dart';

class ProjectsProvider extends ChangeNotifier {
  List<Project> _projects = [];
  Project selectedProject;
  ProjectAPI _projectAPI = ProjectAPI();

  selectProject(Project project) {
    this.selectedProject = project;
    notifyListeners();
  }

  resetSelectedProject() {
    this.selectedProject = null;
    notifyListeners();
  }

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

  Future<bool> createProject(Project projectData) async {
    try {
      final result = await _projectAPI.createProject(
          project: projectData, projectID: projectData.bid);
      if (result == true) _projects.add(projectData);
      notifyListeners();
      return result;
    } on InvalidDataFormat catch (e) {
      print(e.toString());
    } on UnAuthorizedUser catch (e) {
      print(e.toString());
    }
    notifyListeners();
    return false;
  }

  Future<bool> signCurrentProject() async {
    try {
      final result =
          await _projectAPI.signProject(projectID: selectedProject.bid);
      if (result) {
        return true;
      }
    } on UnAuthorizedUser catch (e) {}

    return false;
  }

  Future<Map<String, Project>> getCurrentProjectHistory() async {
    try {
      final result = await _projectAPI.getProjectHistory(projectID: selectedProject.bid);
      if (result != null) {
        return result;
      }
    } on Exception catch (e) {
      print(e);
    }

    return null;
  }

  Future<bool> signCurrentProjectUpdate({updateOrder}) async {
    try {
      final result = await _projectAPI.signUpdate(
          projectID: selectedProject.bid, order: updateOrder);
      if (result == true) {
        selectedProject =
            await _projectAPI.getProjectByID(projectID: selectedProject.bid);
        notifyListeners();
        return true;
      }
    } on UnAuthorizedUser catch (e) {
      print(e.toString());
    }

    return false;
  }
}

import 'package:dpwdapp/api/httpservice.dart';
import 'package:dpwdapp/model/projectModel.dart';

class ProjectAPI {
  HttpService _httpService = HttpService();

  Future<Project> getProjectByID({String projectID}) async {
    final result = await _httpService.getRequest(
        endpoint: "/channel/road/projects/" + projectID);
    if (result.statusCode == 200) {
      Project project = Project.fromJson(result.data);
      return project;
    }
    return null;
  }

  Future<List<Project>> getAllProject() async {
    final result =
        await _httpService.getRequest(endpoint: "/channel/road/projects/all");

    if (result.statusCode == 200) {
      List<Project> projects = result.data.map<Project>((value) {
        return Project.fromJson(value['Record']);
      }).toList();
      return projects;
    }

    return null;
  }
}

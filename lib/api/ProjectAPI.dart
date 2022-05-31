import 'dart:convert';
import 'dart:developer';

import 'package:dpwdapp/api/httpservice.dart';
import 'package:dpwdapp/error/ProjectExceptions.dart';
import 'package:dpwdapp/error/UserExceptions.dart';
import 'package:dpwdapp/model/projectModel.dart';

class ProjectAPI {
  HttpService _httpService = HttpService();

  final String _baseEndpoint = "/channel/road/projects/";

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

  Future<bool> signProject({String projectID}) async {

    final result = await _httpService.postRequest(endpoint: _baseEndpoint+projectID+"/sign");

    if(result.statusCode == 401)
    {
      print(result.data);
      throw UnAuthorizedUser();
    }
    else if(result.statusCode == 200)
    {
      return true;
    }
    return false;
  }

  Future<bool> signUpdate({String projectID, int order}) async
  {
    final result = await _httpService.postRequest(endpoint: _baseEndpoint+projectID+"/signupdate/"+order.toString());

    if(result.statusCode == 401)
    {
      throw UnAuthorizedUser();
    }
    else if(result.statusCode == 200)
    {
      return true;
    }

    return false;
  }

  Future<Map<String,Project>> getProjectHistory({projectID}) async
  {
    final result = await _httpService.getRequest(
        endpoint: "/channel/road/projects/" + projectID +"/history");    
    Map<String,Project> returnData = Map<String,Project>();
    
    if(result.statusCode == 200)
    {
      print("HGELLO ");
      List<dynamic> historyData = result.data["data"];
      historyData.forEach((data){
        final timestamp = data["timestamp"]["seconds"]["low"].toString();
        final projectData = Project.fromJson(data["data"]);
        returnData.addAll({timestamp:projectData});      
      });

      return returnData;
    }
    else if(result.statusCode == 401)
    {
      throw UnAuthorizedUser();
    }

    return null;
  }
  
  Future<bool> createProject({Project project, String projectID}) async
  {
    final projectData = {
        "bid":project.bid,
        "pid":project.pid,
        "name":project.name,
        "desc":project.desc,
        "sDate":project.sDate,
        "apxEndDate":project.apxEndDate,
        "budget":project.budget,
        "contractorID":project.contractorID,
        "signatures":[],
        "updates":[]
    };
    final result = await _httpService.postRequest(endpoint: _baseEndpoint+"/create/"+projectID, data: projectData);

    if(result.statusCode == 401)
    {
      throw UnAuthorizedUser();
    }
    else if(result.statusCode == 400)
    {
      throw InvalidDataFormat();
    }
    else if(result.statusCode == 200)
    {
      return true;
    }
    return false;
  }
}

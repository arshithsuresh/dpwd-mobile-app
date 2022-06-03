import 'dart:convert';

import 'package:dpwdapp/api/httpservice.dart';
import 'package:dpwdapp/error/ProjectExceptions.dart';
import 'package:dpwdapp/error/UserExceptions.dart';
import 'package:dpwdapp/model/complaintModel.dart';

class ComplaintAPI {
  HttpService _httpService = HttpService();

  final String _baseEndpoint = "/channel/road/complaints/";

  Future<Complaint> getComplaintByID({String complaintID}) async {
    final result =
        await _httpService.getRequest(endpoint: _baseEndpoint + complaintID);
    if (result.statusCode == 200) {
      Complaint complaint = Complaint.fromJson(result.data);
      return complaint;
    }
    return null;
  }

  Future<bool> createComplaint({Complaint complaint, String complaintID}) async {

    final updateData = {
      "bid": complaint.bid,
      "complaintID": complaint.complaintID,
      "title": complaint.title,
      "shortDesc": complaint.shortDesc,
      "detailedDesc": complaint.detailedDesc,
      "location": {"lat": "${complaint.location.lat}", "long": "${complaint.location.lng}"},
      "createdDate": complaint.createdDate,
      "region": complaint.region,
      "type": complaint.type,
      "status": complaint.status.toString(),
      "createdBy": complaint.createdBy,
      "upVotes": [complaint.createdBy],
      "signatures":[]
    };
    final result = await _httpService.postRequest(
        endpoint: _baseEndpoint + "create/" + complaintID, data: updateData);

    if (result.statusCode == 401) {
      throw UnAuthorizedUser();
    } else if (result.statusCode == 400) {
      throw InvalidDataFormat();
    } else if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<Complaint>> getAllComplaint() async {
    final result =
        await _httpService.getRequest(endpoint: _baseEndpoint + "all");

    if (result.statusCode == 200) {
      List<Complaint> complaints = result.data.map<Complaint>((value) {
        return Complaint.fromJson(value['Record']);
      }).toList();
      return complaints;
    }

    return null;
  }

  Future<Map<String,Complaint>> getComplaintHistory({complaintID}) async
  {
    final result = await _httpService.getRequest(
        endpoint: "/channel/road/complaints/" + complaintID +"/history");    
    Map<String,Complaint> returnData = Map<String,Complaint>();
    
    if(result.statusCode == 200)
    {      
      List<dynamic> historyData = result.data["data"];
      historyData.forEach((data){
        final timestamp = data["timestamp"]["seconds"]["low"].toString();
        final projectData = Complaint.fromJson(data["data"]);
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

  Future<String> encodeToRegion({Location latLng}) async {
    final result = await _httpService.getRequest(
        endpoint: "/location/encode?lat=${latLng.lat}&long=${latLng.lng}");
    
    if(result.statusCode == 200)
    {
      print(result.data["geohash"]);
      return result.data["geohash"];
    }

    return null;
    
  }

  Future<bool> signComplaint({String complaintID}) async {
    final result = await _httpService.postRequest(
        endpoint: _baseEndpoint + complaintID + "/sign");

    if (result.statusCode == 401) {
      print(result.data);
      throw UnAuthorizedUser();
    } else if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> upVoteComplaint({String complaintID}) async {
    final result = await _httpService.postRequest(
        endpoint: _baseEndpoint + complaintID + "/upvote");

    if (result.statusCode == 401) {
      print(result.data);
      throw UnAuthorizedUser();
    } else if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> setComplaintStatusPending({String complaintID}) async {
    final result = await _httpService.postRequest(
        endpoint: _baseEndpoint + complaintID + "/status/pending");

    if (result.statusCode == 401) {
      print(result.data);
      throw UnAuthorizedUser();
    } else if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> setComplaintStatusVerified({String complaintID}) async {
    final result = await _httpService.postRequest(
        endpoint: _baseEndpoint + complaintID + "/status/verified");

    if (result.statusCode == 401) {
      print(result.data);
      throw UnAuthorizedUser();
    } else if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> setComplaintStatusResolved({String complaintID}) async {
    final result = await _httpService.postRequest(
        endpoint: _baseEndpoint + complaintID + "/status/resolved");

    if (result.statusCode == 401) {
      print(result.data);
      throw UnAuthorizedUser();
    } else if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> setComplaintStatusInvalid({String complaintID}) async {
    final result = await _httpService.postRequest(
        endpoint: _baseEndpoint + complaintID + "/status/invalid");

    if (result.statusCode == 401) {
      print(result.data);
      throw UnAuthorizedUser();
    } else if (result.statusCode == 200) {
      return true;
    }
    return false;
  }
}

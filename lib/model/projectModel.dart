import 'dart:convert';

import 'package:dpwdapp/constants/urlConstants.dart';


class Project {
  String bid;
  String pid;
  String name;
  String desc;
  String sDate;
  String apxEndDate;
  double budget;
  String contractorID;
  List<String> signatures;
  List<ProjectUpdate> updates=[];

  double _status = 0;

  getBID(){
    if(bid.length<16)
    return bid;

    final len= bid.length;
    return bid.substring(0,12)+"...."+ bid.substring(len-6,len-1);
  }

  getStatus(){
    return _status/100.0;
  }

  getStatusPercentage(){
    return _status;
  }

  calculateStatus(){
    updates.forEach((element) =>_status+=element.status);
  }

  Project(
      {this.bid,
      this.pid,
      this.name,
      this.desc,
      this.sDate,
      this.apxEndDate,
      this.budget,
      this.contractorID,
      this.signatures,
      this.updates}){
        calculateStatus();
      }

  factory Project.fromJson(Map<String, dynamic> data) {
   
    List<ProjectUpdate> updates = data['updates']
        .map<ProjectUpdate>((dynamic update) => ProjectUpdate.fromJson(update))
        .toList();    
    return Project(
        bid: data['bid'],
        pid: data['pid'],
        name: data['name'],
        desc: data['desc'],
        sDate: data['sDate'],
        apxEndDate: data['apxEndDate'],
        budget:   double.parse(data['budget'].toString()),
        contractorID: data['contractorID'],
        signatures: data['signatures'].map<String>((val)=>val.toString()).toList(),
        updates: updates);
  }
}

class ProjectUpdate {
  int updateType;
  String title;
  String desc;
  String date;
  List<String> signatures;
  int status;
  String image;

  getImage(){    
    return IPFS_BASE_URL+image;
  }

  ProjectUpdate(
      {this.updateType,
      this.title,
      this.desc,
      this.date,
      this.signatures,
      this.status,
      this.image});

  factory ProjectUpdate.fromJson(Map<String, dynamic> data) {
    
    return ProjectUpdate(
        updateType: int.parse(data['updateType'].toString()),
        title: data['title'],
        desc: data['desc'],
        date: data['date'],
        signatures:  data['signatures'].map<String>((val)=>val.toString()).toList(),
        status: int.parse(data['status'].toString()),
        image: data.containsKey('image')?data['image']:null);
  }
}

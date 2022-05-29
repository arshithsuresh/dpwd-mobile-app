import 'dart:convert';
import 'dart:ffi';

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
  List<ProjectUpdate> updates;

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
      this.updates});

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
        budget: double.parse(data['budget']),
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

  ProjectUpdate(
      {this.updateType,
      this.title,
      this.desc,
      this.date,
      this.signatures,
      this.status});

  factory ProjectUpdate.fromJson(Map<String, dynamic> data) {
    
    return ProjectUpdate(
        updateType: data['updateType'],
        title: data['title'],
        desc: data['desc'],
        date: data['date'],
        signatures:  data['signatures'].map<String>((val)=>val.toString()).toList(),
        status: data['status']);
  }
}

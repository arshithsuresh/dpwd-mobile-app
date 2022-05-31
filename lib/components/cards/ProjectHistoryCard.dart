import 'package:dpwdapp/model/projectModel.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ProjectHistoryCard extends StatelessWidget {

  Project _data;
  DateTime _timestamp;
  
  ProjectHistoryCard(Project data, String timestamp) {
    this._data = data;
    
    this._timestamp = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)*1000);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ProjectsProvider projectsProvider = Provider.of<ProjectsProvider>(context);
    return Container(
      margin: EdgeInsets.only(top:4,bottom: 4),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 3, color: Color.fromRGBO(234, 234, 234, 1)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _timestamp.toString(),
                style: TextStyle(fontSize: 18,),
              ),
              Text(_data.getStatus().toString()+"%", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Text(_data.desc),
          SizedBox(
            height: 4,
          ),
          Text(
            "Progress : %",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              "Signed Authorities",
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: _data.signatures.map((e) {
                                String signature;
                                int len = e.length;
                                if (len > 22) {
                                  signature = e.substring(0, 18) +
                                      "..." +
                                      e.substring(len - 7, len - 1);
                                } else
                                  signature = e;
                                return Text(signature);
                              }).toList(),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"))
                            ],
                          ));
                },
                child:
                    Text("Signed Authorities", style: TextStyle(fontSize: 11)),
              ),
              SizedBox(
                width: 4,
              ),              
            ],
          ),
        ],
      ),
    );
  }
}

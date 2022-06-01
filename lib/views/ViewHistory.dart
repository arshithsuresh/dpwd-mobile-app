import 'package:dpwdapp/components/cards/ProjectCard.dart';
import 'package:dpwdapp/components/cards/ProjectHistoryCard.dart';
import 'package:dpwdapp/model/projectModel.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromRGBO(234, 234, 234, 1),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: SingleChildScrollView(
            child: Consumer<ProjectsProvider>(builder: (context, value, child) {
          return Container(
              padding:
                  EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 40),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 48, bottom: 16),
                  child: Column(
                    children: [
                      Text(
                        "Project History",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${value.selectedProject.name}",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${value.selectedProject.desc}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: FutureBuilder(
                            builder: (context, snapshot) {
                              
                              if(snapshot.hasData)
                              {
                                Map<String,Project> historyData = snapshot.data;
                                List<ProjectHistoryCard> history = [];

                                historyData.forEach((timestamp, project){
                                  history.add(ProjectHistoryCard(project,timestamp));
                                });
                                return Column(
                                children: history);        
                              }                              
                              else if(snapshot.connectionState == ConnectionState.waiting)
                              return CircularProgressIndicator();

                              return Container();
                            },
                            future: value.getCurrentProjectHistory(),
                          ))
                    ],
                  ),
                )
              ]));
        })));
  }
}

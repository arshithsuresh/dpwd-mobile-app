import 'package:dpwdapp/core/Routes.dart';
import 'package:dpwdapp/model/projectModel.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectCard extends StatelessWidget {
  
  Project data;
  bool _wrap;
  bool _clickable = true;
  
  ProjectCard({Project data, bool wrap = false, clickable = false}){
      this.data = data;
      this._wrap = wrap;
      this._clickable = clickable;
  }

  @override
  Widget build(BuildContext context) {

    return Card(
  margin: EdgeInsets.only(top:16),
  elevation: 6,
      child: GestureDetector(
        onLongPress: () {
          showDialog(context: context, builder: (context)=>AlertDialog(
            title: Text(data.name),
            content: Text(data.desc),
            actions: [ElevatedButton(onPressed: ()=>Navigator.pop(context), child: Text("OK"))],
          ));
        },
        onTap: (){

          if(!this._clickable)
          {
            return;
          }

          Provider.of<ProjectsProvider>(context, listen: false).selectProject(this.data);
          Navigator.pushNamed(context, AppRoutes.ROUTE_ViewProjectDetails);
        },
        child: Container(
          padding: EdgeInsets.only(top: 8, right: 12, left: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.pid +" | " + data.bid,
                style: TextStyle(fontSize: 14),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 240,
                        child: Text(
                          data.name,
                          softWrap: true,                      
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        _wrap? data.desc.substring(0,20):data.desc,
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Budget",
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(data.budget.toString()+" Cr."),
                    ],
                  )
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Start ${data.sDate}"), Text("End ${data.apxEndDate}")],
              )
            ],
          ),
        ),
      ),
    );
  
  }
}



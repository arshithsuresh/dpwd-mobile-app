import 'package:dpwdapp/components/cards/ProjectCard.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Projects extends StatelessWidget {
  
  refreshContent(context) =>
      Provider.of<ProjectsProvider>(context, listen: false)
          .initializeAllProjects();
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
          child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 48, bottom: 16),
              child: Column(
                children: [
                  Text(
                    "All Projects",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        refreshContent(context);
                      },
                      icon: Icon(Icons.refresh),
                      iconSize: 14,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints.tightFor()),
                  SizedBox(
                    height: 1,
                  ),
                ],
              ),
            ),
            Consumer<ProjectsProvider>(builder: ((context, datas, child) {
              if (datas.getAllProjects().length > 0)
                return Container(
                    child: Column(
                        children: datas
                            .getAllProjects()
                            .map((data) => ProjectCard(
                                  data: data,
                                  clickable: true,
                                ))
                            .toList()));
              else
                refreshContent(context);
              return Container();
            }))
          ],
        ),
      )),
    );
  }
}

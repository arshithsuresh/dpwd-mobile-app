import 'package:dpwdapp/components/cards/ProjectCard.dart';
import 'package:dpwdapp/components/cards/UpdateCard.dart';
import 'package:dpwdapp/core/Routes.dart';
import 'package:dpwdapp/model/projectModel.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectDetails extends StatelessWidget {

  showSnackbar({context, String message})
  {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    ProjectsProvider projectsProvider = Provider.of<ProjectsProvider>(context);
    Project data = projectsProvider.selectedProject;
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
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
          SizedBox(width: 8,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))
            ),
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.ROUTE_UpdateProject);
            },
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(234, 234, 234, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 80),
              alignment: Alignment.center,
              child: Column(children: [
                ProjectCard(
                  data: data,
                  wrap: false,
                  clickable: false,
                ),
                SizedBox(
                  height: 8,
                ),
                LinearProgressIndicator(
                  minHeight: 8,
                  color: Colors.green,
                  backgroundColor: Colors.white,
                  value: data.getStatus(),
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
                                      children: data.signatures
                                          .map((e) {
                                            String signature;
                                            int len = e.length;
                                            if(len>22)
                                            {
                                              signature = e.substring(0,18)+"..."+e.substring(len-7,len-1);
                                            }
                                            else
                                              signature = e;
                                            return Text(signature);})
                                          .toList(),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("OK"))
                                    ],
                                  ));
                        },
                        child: Text(
                          "Signed Authorities",
                          style: TextStyle(fontSize: 11),
                        )),
                    SizedBox(
                      width: 4,
                    ),
                    if (!userProvider.isPublicUser() &&
                        userProvider.isVerifiedUser())
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
                                      title: Text("Signing Project Update"),
                                      content: Text(
                                          "Are you sure you want to sign this update?"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () => projectsProvider
                                                    .signCurrentProject()
                                                    .then((value) {
                                                  if (value)
                                                    showSnackbar(context: context, message: "Operation Successfull");
                                                  else
                                                    showSnackbar(context: context, message: "Operation Failed!");
                                                  Navigator.pop(context);
                                                }),
                                            child: Text("Yes")),
                                        ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("No"))
                                      ],
                                    ));
                          },
                          child: Text("Sign Project",
                              style: TextStyle(fontSize: 11))),
                    SizedBox(
                      width: 4,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.ROUTE_HistoryPage);
                        },
                        child: Text("View History",
                            style: TextStyle(fontSize: 11))),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                data.updates.length > 0
                    ? Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: data.updates
                              .asMap()
                              .entries
                              .map((e) => UpdateCard(e.value, e.key,interact: true,))
                              .toList(),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        alignment: Alignment.center,
                        child: Text("No Updates for this Project!"),
                      )
              ]))),
    );
  }
}

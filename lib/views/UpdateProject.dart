import 'dart:convert';

import 'package:dpwdapp/api/ProjectAPI.dart';
import 'package:dpwdapp/components/buttons/PrimaryButton.dart';
import 'package:dpwdapp/constants/constants.dart';
import 'package:dpwdapp/core/Routes.dart';
import 'package:dpwdapp/model/projectModel.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'package:crypto/crypto.dart';

class UpdateProject extends StatelessWidget {
  UpdateProject({Key key}) : super(key: key);

  final TextEditingController txtTitle = TextEditingController();
  final TextEditingController txtDate = TextEditingController();
  final TextEditingController txtDesc = TextEditingController();
  final TextEditingController txtProgressUpdate = TextEditingController();

  String txtUpdateType = UpdateType.keys.first;

  dummyProjectInfo() {
    txtTitle.text = "Progress Update";
    txtDate.text = "22/05/2022";
    txtDesc.text = "Road Update status";
    txtProgressUpdate.text = "10";
  }

  Future<bool> updateProject(context) async {
    if (txtTitle.text.length < 5 ||
        txtDate.text.length < 4 ||
        txtDesc.text.length < 10 ||
        txtProgressUpdate.text.length < 1) {
      return false;
    }

    final updateData = ProjectUpdate(
        updateType: UpdateType[txtUpdateType],
        title: txtTitle.text,
        date: txtDate.text,
        desc: txtDesc.text,
        status: int.parse(txtProgressUpdate.text),
        signatures: []);

    final result = await Provider.of<ProjectsProvider>(context, listen: false)
        .updateProjectStatus(update: updateData);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    dummyProjectInfo();
    final projectProvider =
        Provider.of<ProjectsProvider>(context, listen: false);
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
                padding: EdgeInsets.only(left: 32, right: 32, top: 80),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "Update Project",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${projectProvider.selectedProject.name}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("${projectProvider.selectedProject.getBID()}"),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Update Type"),
                          DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    )),
                              ),
                              value: txtUpdateType,
                              items: UpdateType.keys
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (item) {
                                txtUpdateType = item;
                              }),
                          SizedBox(height: 8),
                          Text("Update Titile"),
                          TextField(
                            controller: txtTitle,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ))),
                          ),
                          SizedBox(height: 8),
                          Text("Date"),
                          TextField(
                            keyboardType: TextInputType.datetime,
                            controller: txtDate,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ))),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(height: 8),
                          Text("Description"),
                          TextField(
                            minLines: 3,
                            maxLines: 3,
                            controller: txtDesc,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ))),
                          ),
                          SizedBox(height: 8),
                          Text("Progress Update"),
                          TextField(
                            controller: txtProgressUpdate,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ))),
                          ),
                          SizedBox(height: 8),
                          PrimaryButton(
                              title: "Create",
                              onPressed: () {
                                updateProject(context).then((value) {
                                  if (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("Project Updated!")));
                                    Future.delayed(
                                        Duration(seconds: 3),
                                        () => Navigator.popAndPushNamed(context,
                                            AppRoutes.ROUTE_Dashboard));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Error! Project Updation failed")));
                                  }
                                });
                              })
                        ],
                      ),
                    )
                  ],
                ))));
  }
}

import 'package:dpwdapp/api/ProjectAPI.dart';
import 'package:dpwdapp/components/buttons/PrimaryButton.dart';
import 'package:dpwdapp/core/Routes.dart';
import 'package:dpwdapp/model/projectModel.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class CreateProject extends StatelessWidget {
  CreateProject({Key key}) : super(key: key);

  final TextEditingController txtBID = TextEditingController();
  final TextEditingController txtPID = TextEditingController();
  final TextEditingController txtSDate = TextEditingController();
  final TextEditingController txtApxEndDate = TextEditingController();
  final TextEditingController txtBudget = TextEditingController();
  final TextEditingController txtRegion = TextEditingController();
  final TextEditingController txtDesc = TextEditingController();
  final TextEditingController txtContractorID = TextEditingController();

  Future<bool> createProject(context) async {

    if(txtBID.text.length<5 || txtPID.text.length<5 || txtSDate.text.length<4 || txtApxEndDate.text.length<4 ||
        txtBudget.text.length<2 || txtDesc.text.length<10 || txtContractorID.text.length<5)
        {
          return false;
        }

    final projectData = Project(
        bid: txtBID.text,
        pid: txtPID.text,
        sDate: txtSDate.text,
        apxEndDate: txtApxEndDate.text,
        budget: double.parse(txtBudget.text),
        desc: txtDesc.text,
        contractorID: txtContractorID.text);

    final result =
        await Provider.of<ProjectsProvider>(context).createProject(projectData);

    return result;
  }

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
                padding: EdgeInsets.only(left: 32, right: 32, top: 80),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "Create New Project",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
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
                          Text("B Project ID"),
                          TextField(
                            controller: txtBID,
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
                          Text("Project ID"),
                          TextField(
                            controller: txtPID,
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 125,
                                child: Column(
                                  children: [
                                    Text("Start Date"),
                                    TextField(
                                      keyboardType: TextInputType.datetime,
                                      controller: txtSDate,
                                      decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ))),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 125,
                                child: Column(
                                  children: [
                                    Text("End Date"),
                                    TextField(
                                      keyboardType: TextInputType.datetime,
                                      controller: txtApxEndDate,
                                      decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ))),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Text("Budget"),
                          TextField(
                            controller: txtBudget,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Region"),
                                  Container(
                                    width: 200,
                                    child: TextField(
                                      controller: txtRegion,
                                      decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ))),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  alignment: Alignment.bottomRight,
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(left: 4),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(Icons.location_pin),
                                    style: ElevatedButton.styleFrom(
                                        maximumSize: Size(60, 50),
                                        minimumSize: Size(60, 50)),
                                  ))
                            ],
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
                          Text("Contractor"),
                          TextField(
                            controller: txtContractorID,
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
                                createProject(context).then((value) {
                                  if (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("Project Created!")));
                                    Future.delayed(
                                        Duration(seconds: 3),
                                        () => Navigator.pushNamed(context,
                                            AppRoutes.ROUTE_Dashboard));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Error! Project Creation failed")));
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

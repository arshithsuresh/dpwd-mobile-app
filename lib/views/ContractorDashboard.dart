import 'package:dpwdapp/core/Routes.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContractorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromRGBO(234, 234, 234, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 32, right: 32),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 48, bottom: 28),
                child: Column(
                  children: [
                    Text(
                      "D-PWD",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      Provider.of<UserProvider>(context,listen: false).curUser.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Complaints"),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.ROUTE_ViewComplaints);
                          },
                          child: Text("View Complaints"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 48),
                              elevation: 0,
                              primary: Colors.green),
                        ),
                      ],
                    ),
                  )
                ],
              )),
              Container(
                margin: EdgeInsets.only(top:16),
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Projects"),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.ROUTE_ViewProjects);
                          },
                          child: Text("View On Going Projects"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 48),
                              elevation: 0,
                              primary: Colors.green),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.ROUTE_ViewProjects);
                          },
                          child: Text("View All Projects"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 48),
                              elevation: 0,
                              primary: Colors.green),
                        ),
                      ],
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

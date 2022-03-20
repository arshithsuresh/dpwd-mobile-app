import 'package:dpwdapp/components/buttons/PrimaryButton.dart';
import 'package:dpwdapp/core/Routes.dart';
import 'package:flutter/material.dart';

class PublicUserDashboard extends StatelessWidget {
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
        onPressed: () {},
      ),
      backgroundColor: Color.fromRGBO(234, 234, 234, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 32, right: 32, bottom: 32),
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
                      "Username",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        PrimaryButton(
                          title: "View My Complaints",
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.ROUTE_ViewComplaints);
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        PrimaryButton(
                          onPressed: () {},
                          title: "Register New Complaint",
                        ),
                      ],
                    ),
                  )
                ],
              )),
              Container(
                  margin: EdgeInsets.only(top: 16),
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
                            PrimaryButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.ROUTE_ViewProjects);
                              },
                              title: "View On Going Projects",
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            PrimaryButton(
                              onPressed: () {},
                              title: "View Upcoming Projects",
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            PrimaryButton(
                                onPressed: () {}, title: "View All Projects"),
                          ],
                        ),
                      )
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Road Projects"),
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
                            PrimaryButton(
                              onPressed: () {},
                              title: "View OnComing Projects",
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            PrimaryButton(
                              onPressed: () {},
                              title: "View On Going Projects",
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            PrimaryButton(
                              onPressed: () {},
                              title: "View On All Projects",
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

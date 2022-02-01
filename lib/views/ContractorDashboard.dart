import 'package:flutter/material.dart';

class ContractorDashboard extends StatelessWidget {
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
                      "ABC Contractors",
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
                  Text("Complaints on your Projects"),
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
                          onPressed: () {},
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
                  Text("Your Projects"),
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
                          onPressed: () {},
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
                          onPressed: () {},
                          child: Text("View Upcoming Projects"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 48),
                              elevation: 0,
                              primary: Colors.green),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {},
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
              Container(
                margin: EdgeInsets.only(top:16),
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Suppliers"),
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
                          onPressed: () {},
                          child: Text("View All Supliers"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 48),
                              elevation: 0,
                              primary: Colors.green),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Orders"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 48),
                              elevation: 0,
                              primary: Colors.green),
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

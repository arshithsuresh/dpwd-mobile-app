import 'package:dpwdapp/components/cards/ComplaintCard.dart';
import 'package:dpwdapp/state/complaints/ComplaintProvider.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Complaints extends StatelessWidget {
  refreshContent(context) =>
      Provider.of<ComplaintProvider>(context, listen: false)
          .initializeAllComplaints();

  getMyComplaints(context) {
      final user = Provider.of<UserProvider>(context, listen: false).curUser.id;
      Provider.of<ComplaintProvider>(context, listen: false)
          .getUserComplaints(user: user);
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
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 48, bottom: 16),
              child: Column(
                children: [
                  Text(
                    "All Complaints",
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
                    height: 12,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {
                  getMyComplaints(context);
                }, child: Text("My Complaints")),
                SizedBox(width: 8,),
                ElevatedButton(onPressed: () {
                  refreshContent(context);
                }, child: Text("All"))
              ],
            ),
            Consumer<ComplaintProvider>(builder: ((context, datas, child) {
              if (datas.getAllComplaints().length > 0)
                return Container(
                    child: Column(
                        children: datas
                            .getAllComplaints()
                            .map((data) => ComplaintCard(
                                  complaint: data,
                                  clickable: true,
                                ))
                            .toList()));
              else
                refreshContent(context);
              return Container();
            })),
          ],
        ),
      )),
    );
  }
}

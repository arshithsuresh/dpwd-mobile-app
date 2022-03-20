import 'package:dpwdapp/components/cards/ComplaintCard.dart';
import 'package:flutter/material.dart';

class Complaints extends StatelessWidget {
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
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Container(
                child: Column(children: [
              ComplaintCard(),
              ComplaintCard(),
              ComplaintCard(),
              ComplaintCard(),
            ]))
          ],
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';

Widget ComplaintCard() => Card(
      margin: EdgeInsets.only(top: 16),
      elevation: 6,
      child: Container(
        padding: EdgeInsets.only(top: 8, right: 12, left: 12, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Regions : Cherthala, Alappuzha",
              style: TextStyle(fontSize: 14),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Road Construction",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Pending Verification",
                  style: TextStyle(fontSize: 14, color: Colors.orange),
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date 06-01-2022"),
                ElevatedButton(
                  child: Row(
                    children: [
                      Icon(Icons.thumb_up),
                      Text("5"),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );

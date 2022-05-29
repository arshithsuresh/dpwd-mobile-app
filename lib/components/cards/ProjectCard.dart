import 'package:flutter/material.dart';

Widget ProjectCard() => Card(
  margin: EdgeInsets.only(top:16),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Road Construction",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Status : Design State",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Budget",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("50 Lakhs"),
                  ],
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Start 06-01-2022"), Text("End 06-01-2022")],
            )
          ],
        ),
      ),
    );

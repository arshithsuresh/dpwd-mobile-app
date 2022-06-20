import 'dart:developer';

import 'package:dpwdapp/components/cards/ComplaintCard.dart';
import 'package:dpwdapp/components/cards/ProjectCard.dart';
import 'package:dpwdapp/components/cards/UpdateCard.dart';
import 'package:dpwdapp/constants/constants.dart';
import 'package:dpwdapp/core/Routes.dart';
import 'package:dpwdapp/model/complaintModel.dart';
import 'package:dpwdapp/model/projectModel.dart';
import 'package:dpwdapp/state/complaints/ComplaintProvider.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class ComplaintDetails extends StatelessWidget {
  showSnackbar({context, String message}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  showActionConfimation({BuildContext context, String message, action}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Confirm Action"),
              content: Text(message),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () => action().then((value) {
                          if (value)
                            showSnackbar(
                                context: context,
                                message: "Operation Successfull");
                          else
                            showSnackbar(
                                context: context, message: "Operation Failed!");
                          Navigator.pop(context);
                        }),
                    child: Text("Yes")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                    child: Text("No"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    ComplaintProvider complaintProvider =
        Provider.of<ComplaintProvider>(context);
    Complaint data = complaintProvider.selectedComplaint;
    UserProvider userProvider = Provider.of<UserProvider>(context);

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
              padding: EdgeInsets.only(left: 12, right: 12, top: 80),
              alignment: Alignment.center,
              child: Column(children: [
                ComplaintCard(
                  complaint: data,
                  wrap: false,
                  clickable: false,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    if (userProvider.isVerifiedUser())
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
                                      title: Text("Signing Complaint"),
                                      content: Text(
                                          "Are you sure you want to sign this complaint?"),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.green),
                                            onPressed: () => complaintProvider
                                                    .signCurrentComplaint()
                                                    .then((value) {
                                                  if (value)
                                                    showSnackbar(
                                                        context: context,
                                                        message:
                                                            "Operation Successfull");
                                                  else
                                                    showSnackbar(
                                                        context: context,
                                                        message:
                                                            "Operation Failed!");
                                                  Navigator.pop(context);
                                                }),
                                            child: Text("Yes")),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.grey),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("No"))
                                      ],
                                    ));
                          },
                          child: Text("Sign Complaint",
                              style: TextStyle(fontSize: 11))),
                    SizedBox(
                      width: 4,
                    ),
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
                                      "Complaint Voted By",
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: data.upVotes.map((e) {
                                        String signature;
                                        int len = e.length;
                                        if (len > 22) {
                                          signature = e.substring(0, 18) +
                                              "..." +
                                              e.substring(len - 7, len - 1);
                                        } else
                                          signature = e;
                                        return Text(signature);
                                      }).toList(),
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
                          "Up Votes",
                          style: TextStyle(fontSize: 11),
                        )),
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
                          // Navigator.pushNamed(context, AppRoutes.ROUTE_HistoryPage);
                        },
                        child: Text("View History",
                            style: TextStyle(fontSize: 11))),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Complaint Id"),
                            Text(data.getBID(),
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Title"),
                            Text(data.title,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Description"),
                            Container(
                                alignment: Alignment.centerRight,
                                width: 200,
                                child: Text(data.detailedDesc,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)))
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Created By"),
                            Text(data.getCreatedByID(),
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Signature Count"),
                            Text(
                                data.getNumberOfSignatures().toString() +
                                    " Signed",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Votes "),
                            Text(
                                data.getNumberOfUpVotes().toString() + " Votes",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Status"),
                            Text(ComplaintStatus[data.status],
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Type"),
                            Text(data.type,
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Region"),
                            GestureDetector(
                              onTap: () {
                                print("Region Open");
                              },
                              child: Text(data.region,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Actions Available",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 4,
                  children: [
                    if (userProvider.isGovtUser() ||
                        userProvider.isContractorUser())
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.orangeAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          onPressed: () {
                            showActionConfimation(
                                context: context,
                                message:
                                    "Are you sure you want to flag this complaint as Pending Verification?",
                                action: complaintProvider
                                    .updateComplaintStatusPending);
                          },
                          child: Text("Flag Pending Verification")),
                    if (userProvider.isGovtUser() ||
                        userProvider.isContractorUser())
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          onPressed: () {
                            showActionConfimation(
                                context: context,
                                message:
                                    "Are you sure you want to flag this complaint as Verified?",
                                action: complaintProvider
                                    .updateComplaintStatusVerified);
                          },
                          child: Text("Flag Verified")),
                    if (userProvider.isGovtUser())
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          onPressed: () {
                            showActionConfimation(
                                context: context,
                                message:
                                    "Are you sure you want to flag this complaint as Pending Verification?",
                                action: complaintProvider
                                    .updateComplaintStatusResolved);
                          },
                          child: Text("Flag Resolved")),
                    if (userProvider.isGovtUser())
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          onPressed: () {
                            showActionConfimation(
                                context: context,
                                message:
                                    "Are you sure you want to flag this complaint as Pending Verification?",
                                action: complaintProvider
                                    .updateComplaintStatusInvalid);
                          },
                          child: Text("Flag Invalid")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.ROUTE_ViewOnMap,
                              arguments:
                                  LatLng(data.location.lat, data.location.lng));
                        },
                        child: Text("Show on Map")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Upvote Complaint"),
                                    content: Text(
                                        "Are you sure you want to upvote this complaint?"),
                                    actions: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green),
                                          onPressed: () => complaintProvider
                                                  .upVoteCurrentComplaint()
                                                  .then((value) {
                                                if (value)
                                                  showSnackbar(
                                                      context: context,
                                                      message:
                                                          "Operation Successfull");
                                                else
                                                  showSnackbar(
                                                      context: context,
                                                      message:
                                                          "Operation Failed!");
                                                Navigator.pop(context);
                                              }),
                                          child: Text("Yes")),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.grey),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("No"))
                                    ],
                                  ));
                        },
                        child: Text("Up Vote")),
                        if(data.image !=null)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {                                
                                return AlertDialog(
                                  content: Container(
                                      child: Image(
                                    image: NetworkImage(
                                        data.getImage()),
                                  )),
                                );
                              });
                        },
                        child: Text("Show Images"))
                  ],
                )
              ]))),
    );
  }
}

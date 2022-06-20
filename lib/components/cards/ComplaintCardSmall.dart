import 'package:dpwdapp/constants/constants.dart';
import 'package:dpwdapp/core/Routes.dart';
import 'package:dpwdapp/model/complaintModel.dart';
import 'package:dpwdapp/state/complaints/ComplaintProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComplaintCardSmall extends StatelessWidget {
  Complaint data;
  bool _wrap;
  bool _clickable;

  ComplaintCardSmall(
      {Complaint complaint, bool clickable = true, bool wrap = false}) {
    this.data = complaint;
    this._wrap = wrap;
    this._clickable = clickable;
  }

  showSnackbar({context, String message}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(      
      onTap: () {
        if (!this._clickable) {
          return;
        }

        Provider.of<ComplaintProvider>(context, listen: false)
            .selectComplaint(this.data);
        Navigator.pushNamed(context, AppRoutes.ROUTE_ViewComplaintDetails);
      },
      child: Card(
        margin: EdgeInsets.only(top: 16),
        elevation: 6,
        child: Container(
          padding: EdgeInsets.only(top: 8, right: 12, left: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "${data.shortDesc}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                ComplaintStatus[data.status],
                style: TextStyle(fontSize: 14, color: Colors.orange),
              ),
              SizedBox(height: 4,),
              Text(data.createdDate,
                  style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                                    "Complaint Image",
                                  ),
                                  content: Container(
                                    child: Image(image: NetworkImage(data.getImage())),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("OK"))
                                  ],
                                ));
                      },
                      child: Text(
                        "Image",
                        style: TextStyle(fontSize: 11),
                      )),
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
                                    title: Text("Upvote Complaint?"),
                                    content: Text(
                                        "Are you sure you want to upvote this complaint?"),
                                    actions: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green),
                                          onPressed: () =>  Provider.of<ComplaintProvider>(context, listen: false)
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
                      child: Text(
                        "Up Vote ${data.getNumberOfUpVotes()}",
                        style: TextStyle(fontSize: 11),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

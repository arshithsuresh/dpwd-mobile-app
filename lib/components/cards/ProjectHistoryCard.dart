import 'package:dpwdapp/components/cards/UpdateCard.dart';
import 'package:dpwdapp/model/projectModel.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ProjectHistoryCard extends StatelessWidget {
  Project _data;
  DateTime _timestamp;

  ProjectHistoryCard(Project data, String timestamp) {
    this._data = data;

    this._timestamp =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ProjectsProvider projectsProvider = Provider.of<ProjectsProvider>(context);
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                margin:
                    EdgeInsets.only(top: 90, bottom: 90, left: 12, right: 12),
                padding:
                    EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
                height: double.minPositive,
                width: double.maxFinite,
                child: SingleChildScrollView(
                    child: Column(
                  children: _data.updates
                      .asMap()
                      .entries
                      .map((e) => UpdateCard(e.value, e.key,interact: false,))
                      .toList(),
                )),
              );
            });
      },
      child: Container(
        margin: EdgeInsets.only(top: 4, bottom: 4),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 3, color: Color.fromRGBO(234, 234, 234, 1)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _timestamp
                      .toString()
                      .substring(0, _timestamp.toString().length - 4),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(_data.getStatusPercentage().toString() + "%",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Signatures : " + _data.signatures.length.toString()),
                Text("Updates : " + _data.updates.length.toString()),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
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
                                "Signed Authorities",
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: _data.signatures.map((e) {
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
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("OK"))
                              ],
                            ));
                  },
                  child: Text("Signed Authorities",
                      style: TextStyle(fontSize: 11)),
                ),
                SizedBox(
                  width: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

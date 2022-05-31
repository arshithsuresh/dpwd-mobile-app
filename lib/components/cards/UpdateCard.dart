import 'package:dpwdapp/model/projectModel.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class UpdateCard extends StatelessWidget {
  ProjectUpdate _data;
  int _index = -1;
  UpdateCard(ProjectUpdate data, int index) {
    this._data = data;
    this._index = index;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ProjectsProvider projectsProvider = Provider.of<ProjectsProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _data.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(_data.date, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Text(_data.desc),
          SizedBox(
            height: 4,
          ),
          Text(
            "Progress : ${_data.status}%",
            style: TextStyle(fontWeight: FontWeight.bold),
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
                child:
                    Text("Signed Authorities", style: TextStyle(fontSize: 11)),
              ),
              SizedBox(
                width: 4,
              ),
              if (!userProvider.isPublicUser() && userProvider.isVerifiedUser())
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
                                title: Text("Signing Project Update"),
                                content: Text(
                                    "Are you sure you want to sign this update?"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () => projectsProvider
                                          .signCurrentProjectUpdate(
                                              updateOrder: _index)
                                          .then((value) =>
                                              Navigator.pop(context)),
                                      child: Text("Yes")),
                                  ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("No"))
                                ],
                              ));
                    },
                    child: Text(
                      "Sign Project",
                      style: TextStyle(fontSize: 11),
                    ))
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:dpwdapp/api/UserAPI.dart';
import 'package:dpwdapp/core/Routes.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImportWallet extends StatelessWidget {
  UserAPI _userAPI = UserAPI();

  final txtUsernameController = TextEditingController();
  final txtPasswordController = TextEditingController();

  ImportWallet() {
    txtUsernameController.text = "testuser";
    txtPasswordController.text = "hashedpassword";
  }

  @override
  Widget build(BuildContext context) {
    print("Build");

    return Scaffold(
      backgroundColor: Color.fromRGBO(234, 234, 234, 1),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
            primary: true,
            child: Container(
              padding: EdgeInsets.only(left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "D-PWD",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Decentralized PWD",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Import Account",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Username",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 4),
                      TextField(
                        controller: txtUsernameController,
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ))),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 4),
                      TextField(
                        controller: txtPasswordController,
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ))),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<UserProvider>(context, listen: false).LogInUser(
                          username: txtUsernameController.text,
                          password: txtPasswordController.text ).then((loggedin){
                            if(loggedin)
                              Navigator.pushNamed(context, AppRoutes.ROUTE_Dashboard);
                          });
                    },
                    child: Text("LOGIN"),
                    style: ElevatedButton.styleFrom(
                        elevation: 0, primary: Colors.green),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

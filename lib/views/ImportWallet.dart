import 'package:dpwdapp/core/Routes.dart';
import 'package:flutter/material.dart';

class ImportWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      "Unique ID",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 4),
                    TextField(
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
                      "Key Phrase",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 4),
                    TextField(
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
                    Navigator.pushNamed(context, AppRoutes.ROUTE_LoginPage);
                  },
                  child: Text("LOGIN"),
                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: Colors.green),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:dpwdapp/core/Routes.dart';
import 'package:dpwdapp/state/complaints/ComplaintProvider.dart';
import 'package:dpwdapp/state/project/ProjectProvider.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:dpwdapp/views/ContractorDashboard.dart';
import 'package:dpwdapp/views/GovtOfficialDashboard.dart';
import 'package:dpwdapp/views/ImportWallet.dart';
import 'package:dpwdapp/views/LoginPage.dart';
import 'package:dpwdapp/views/PublicUserDashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(providers: [ 
        ChangeNotifierProvider(create: (ctx)=> new UserProvider()),
        ChangeNotifierProvider(create: (ctx)=> new ProjectsProvider()),
        ChangeNotifierProvider(create: (ctx)=> new ComplaintProvider())
      ],
      child: MyApp(),
      )
      
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D-PWD',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
           
      initialRoute: AppRoutes.ROUTE_SignupPage,
      onGenerateRoute: AppRoutes.generateRoutes,
    );
  }
}


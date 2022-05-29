import 'package:dpwdapp/views/ImportWallet.dart';
import 'package:dpwdapp/views/ProjectDetails.dart';
import 'package:dpwdapp/views/Projects.dart';
import 'package:dpwdapp/views/PublicUserDashboard.dart';
import 'package:flutter/material.dart';
import 'package:dpwdapp/views/LoginPage.dart';

class AppRoutes {
  static const ROUTE_LoginPage = "/login";
  static const ROUTE_SignupPage = "/signup";

  static const ROUTE_Dashboard = "/dashboard";

  static const ROUTE_ViewComplaints = "/complaints";
  static const ROUTE_NewComplaint = "/newComplaint";

  static const ROUTE_ViewProjects = "/projects";

  static const ROUTE_ViewProjectDetails = "/project";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {

      case ROUTE_LoginPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginPage(),
        );
      break;

      case ROUTE_SignupPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ImportWallet(),
        );
      break;

      case ROUTE_Dashboard:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PublicUserDashboard(),
        );
      break;

      case ROUTE_ViewProjects:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProjectDetails(),
        );
      break;
      case ROUTE_ViewComplaints:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Projects(),
        );
      break;
    }
  }
}

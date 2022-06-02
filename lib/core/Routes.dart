import 'package:dpwdapp/views/ComplaintDetails.dart';
import 'package:dpwdapp/views/Complaints.dart';
import 'package:dpwdapp/views/ContractorDashboard.dart';
import 'package:dpwdapp/views/CreateComplaint.dart';
import 'package:dpwdapp/views/CreateProject.dart';
import 'package:dpwdapp/views/Dashboard.dart';
import 'package:dpwdapp/views/GovtOfficialDashboard.dart';
import 'package:dpwdapp/views/ImportWallet.dart';
import 'package:dpwdapp/views/ProjectDetails.dart';
import 'package:dpwdapp/views/Projects.dart';
import 'package:dpwdapp/views/PublicUserDashboard.dart';
import 'package:dpwdapp/views/UpdateProject.dart';
import 'package:dpwdapp/views/ViewHistory.dart';
import 'package:dpwdapp/views/ViewMap.dart';
import 'package:flutter/material.dart';
import 'package:dpwdapp/views/LoginPage.dart';

class AppRoutes {
  static const ROUTE_LoginPage = "/login";
  static const ROUTE_SignupPage = "/signup";

  static const ROUTE_Dashboard = "/dashboard";

  static const ROUTE_ViewComplaints = "/complaints";
  static const ROUTE_ViewComplaintDetails = "/complaint";
  static const ROUTE_NewComplaint = "/newComplaint";

  static const ROUTE_ViewProjects = "/projects";

  static const ROUTE_ViewProjectDetails = "/project";

  static const ROUTE_CreateProject = '/createProject';
  static const ROUTE_CreateComplaint = '/createComplaint';

  static const ROUTE_HistoryPage = '/projectHistory';
  static const ROUTE_UpdateProject = '/updateProject';

  static const ROUTE_ViewOnMap = '/viewOnMap';
  

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_CreateProject:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CreateProject(),
        );
        break;

      case ROUTE_CreateComplaint:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CreateComplaint(),
        );
        break;

      case ROUTE_ViewOnMap:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ViewOnMap(),
        );
        break;

      case ROUTE_UpdateProject:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => UpdateProject(),
        );
        break;

      case ROUTE_HistoryPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ViewHistory(),
        );
        break;

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
          builder: (_) => Dashboard(),
        );
        break;

      case ROUTE_ViewProjectDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProjectDetails(),
        );
        break;

      case ROUTE_ViewProjects:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Projects(),
        );
        break;
      case ROUTE_ViewComplaints:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Complaints(),
        );
        break;
      case ROUTE_ViewComplaintDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ComplaintDetails(),
        );
        break;
    }
  }
}

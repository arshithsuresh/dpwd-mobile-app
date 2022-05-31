import 'package:dpwdapp/constants/constants.dart';
import 'package:dpwdapp/state/user/UserProvider.dart';
import 'package:dpwdapp/views/ContractorDashboard.dart';
import 'package:dpwdapp/views/GovtOfficialDashboard.dart';
import 'package:dpwdapp/views/PublicUserDashboard.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder:(context, userData, child){
      switch(userData.curUser.organization)
      {
        case GOVT_ORG:
          return GovtOfficialDashboard();
        break;
        case PUBLIC_ORG:
          return PublicUserDashboard();
        break;
        case CONTRACTOR_ORG:
          return ContractorDashboard();
        break;
        default:
          return PublicUserDashboard();
        break;
      }
    },);
    
  }
}
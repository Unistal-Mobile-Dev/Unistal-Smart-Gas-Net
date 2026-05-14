import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/domain/model/HindranceListModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';

class AppConfig {
  static AppConfig? instance;
  RoleType? roleType;
  Client? client;

  static AppConfig? instanceInit() {
    instance ??= AppConfig();
    return instance;
  }

  String dashboardLink = "";
  String dashboardToken = "";
  String _buildNumber = "";
  String get buildNumber => _buildNumber;
  LoginDataModel loginData = LoginDataModel();


  String sectionId = "";
  List<ActivitySectionData> listOfActivitySection = [];

  HindranceListData hindranceListData = HindranceListData();

  setClient({required Client client}) {
    this.client = client;
  }

  static DeviceType getDeviceType({BuildContext? context}) {
    var isPortrait = true;
    if (context != null) {
      isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    }

/*    final MediaQueryData data = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single);
       return data.size.shortestSide <= 600
        ? DeviceType.phone
        : DeviceType.tablet;*/

    return isPortrait == true ? DeviceType.phone : DeviceType.tablet;
  }

  setLoginData({required LoginDataModel newLoginData}) {
    this.loginData = newLoginData;
  }

  void setDashboardLink({required String link}) {
    dashboardLink = link;
    print("dashboardLink : $dashboardLink");
  }

  void setDashboardToken({required String token}) {
    dashboardToken = token;
    print("dashboardToken : $token");
  }


  void setBuildNumber({required String buildNumber}) {
    _buildNumber = buildNumber;
    print("buildNumber : $_buildNumber");
  }

  void setSectionId({required String newSectionId}) {
    sectionId = newSectionId;
  }

  void setListActivityData({required List<ActivitySectionData> newListOfActivitySection}) {
    listOfActivitySection = newListOfActivitySection;
  }

  void setHindranceListData({required HindranceListData newValue}) {
    hindranceListData = newValue;
  }

}

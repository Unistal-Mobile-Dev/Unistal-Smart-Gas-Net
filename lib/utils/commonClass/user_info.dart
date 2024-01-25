

import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';

class UserInfo {

  static UserInfo? instance;
  LoginDataModel? userData;

  static UserInfo? instanceInit(){
    instance ??= UserInfo();
    return instance;
  }

   setUserInfo(LoginDataModel useData){
     userData ??= LoginDataModel();
     userData = useData;
  }
}
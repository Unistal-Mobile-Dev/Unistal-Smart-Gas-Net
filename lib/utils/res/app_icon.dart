import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';

import 'enums.dart';

class AppIcon {
  static appLogo() {
    switch (AppConfig.instanceInit()!.client) {
      case Client.mgl:
        return AppIcon.appLogoMGL;
      case Client.pbgpl:
        return AppIcon.appLogoPurvaBharti;
      case Client.unistal:
        return AppIcon.appLogoUnistal;
      case Client.hpoil:
        return AppIcon.hpOilLogo;
      case Client.vppl:
      case Client.gjpl:
        return AppIcon.vpplLogo;
      case Client.vrpl:
      case Client.jdpl:
      case Client.bcpl:
      case Client.dbpl:
        return AppIcon.vrplLogo;
      case Client.agcl:
        return AppIcon.agclLogo;
      case Client.pjpl:
        return AppIcon.pjplLogo;
      case Client.urjagati:
        return AppIcon.urjagatiLogo;
      default:
        return AppIcon.appLogoUnistal;
    }
  }

  static smartLogo() {
    switch (AppConfig.instanceInit()!.client) {
      case Client.mgl:
      case Client.pbgpl:
      case Client.unistal:
      case Client.hpoil:
      case Client.agcl:
        return AppIcon.smartgasnetLog;
      case Client.vppl:
      case Client.vrpl:
      case Client.gjpl:
      case Client.jdpl:
      case Client.bcpl:
      case Client.dbpl:
      case Client.pjpl:
      case Client.urjagati:
        return AppIcon.pcmsLog;
      default:
        return "";
    }
  }

  static get appLogoPurvaBharti => "assets/logo/pbg_logo.png";
  static get appLogoMGL        => "assets/logo/mgl_logo.png";
  static get appLogoUnistal    => "assets/logo/unistal_logo.png";
  static get appLogoIgl        => "assets/logo/igl_logo";
  static get oilIndiaLogo      => "assets/logo/oil_india_logo.png";
  static get hpOilLogo         => "assets/logo/hp_oil_logo.png";
  static get vpplLogo          => "assets/logo/vppl_logo.png";
  static get vrplLogo          => "assets/logo/vrpl_logo.png";
  static get pjplLogo          => "assets/logo/pjpl_logo.png";
  static get urjagatiLogo          => "assets/logo/urjagati_logo.png";

  static get colourStrip       => "assets/ic_strip.png";
  static get smartgasnetLog    => "assets/smartgasnet_log.png";
  static get pcmsLog           => "assets/pcms-logo.png";
  static get agclLogo          => "assets/agcl_banner.png";
}
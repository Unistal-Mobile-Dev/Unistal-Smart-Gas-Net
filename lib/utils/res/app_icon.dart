import 'package:flutter_unistal_smart_gas_net/utils/commonClass/app_config.dart';

import 'enums.dart';

class AppIcon {
  static appLogo() {
    return AppConfig.instanceInit()!.client == Client.mgl
        ? AppIcon.appLogoMGL
        : AppConfig.instanceInit()!.client == Client.pbgpl
            ? AppIcon.appLogoPurvaBharti
            : AppConfig.instanceInit()!.client == Client.unistal
                ? AppIcon.appLogoUnistal
                : AppConfig.instanceInit()!.client == Client.hpoil
                    ? AppIcon.hpOilLogo
                    : AppConfig.instanceInit()!.client == Client.vppl
                        ? AppIcon.vpplLogo
                        : AppConfig.instanceInit()!.client == Client.vrpl
                            ? AppIcon.vrplLogo
                            : AppConfig.instanceInit()!.client == Client.gjpl
                                ? AppIcon.vpplLogo
                                : AppConfig.instanceInit()!.client == Client.jdpl
                                    ? AppIcon.vrplLogo
         : AppConfig.instanceInit()!.client == Client.brcpl
                                        ? AppIcon.vrplLogo
                                        : AppIcon.appLogoUnistal;
  }

  static get appLogoPurvaBharti => "assets/logo.png";

  static get appLogoMGL => "assets/ic_launcher_mgl.png";

  static get appLogoUnistal => "assets/unistal_logo.png";

  static get appLogoIgl => "assets/ic_launcher_igl.png";

  static get colourStrip => "assets/ic_strip.png";

  static get smartgasnetLog => "assets/smartgasnet_log.png";

  static get vpplLogo => "assets/vppl_logo.png";

  static get vrplLogo => "assets/vrpl_logo.png";

  static get oilIndiaLogo => "assets/oil_india_logo.png";

  static get hpOilLogo => "assets/hp_oil_logo.png";

  static get loader => "assets/ic_loader.gif";
}

import 'package:flutter/material.dart';

@immutable
class EnvironmentConfig extends InheritedWidget {
  final EnvironmentFlavours flavours;

  const EnvironmentConfig({
    super.key,
    required this.flavours,
    required super.child,
  });

  static EnvironmentConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw false;
  }

  String get generalUrlBaseOnFlavour {
    switch (flavours) {
      case EnvironmentFlavours.developmentUnistal:
        return "https://unistaldev.plcms.net/";
       // return "https://unistaluat.plcms.net/";
      //  return "http://unistal.smartgasnet.com/";
      case EnvironmentFlavours.productionUnistal:
        return "http://unistal.smartgasnet.com/";
      case EnvironmentFlavours.developmentPurvaBharti:
        return "https://pbgpluat.smartgasnet.com";
      case EnvironmentFlavours.productionPurvaBharti:
        return "https://pbgpl.smartgasnet.com/";
      case EnvironmentFlavours.developmentIgl:
        return "https://igl.smartgasnet.com/";
      case EnvironmentFlavours.productionIgl:
        return "https://igl.smartgasnet.com/";
      case EnvironmentFlavours.developmentMgl:
        return "https://mgldev.smartgasnet.com/";
      case EnvironmentFlavours.productionMgl:
        return "https://mgl.smartgasnet.com/";
      case EnvironmentFlavours.developmentOilIndia:
       return "https://tpimsdev.smartgasnet.com/";
      case EnvironmentFlavours.productionOilIndia:
        return "https://tpimsdev.smartgasnet.com/";
      case EnvironmentFlavours.developmentVPPL:
        return "https://vppl.plcms.net/";
      case EnvironmentFlavours.productionVPPL:
        return "https://vppl.plcms.net/";
      case EnvironmentFlavours.developmentVRPL:
        return "https://vrpl.plcms.net/";
      case EnvironmentFlavours.productionVRPL:
        return "https://vrpl.plcms.net/";
    }
  }

  Color get primaryTheme {
    switch (flavours) {
      case EnvironmentFlavours.productionPurvaBharti:
        return Colors.green.shade800;
      case EnvironmentFlavours.developmentPurvaBharti:
        return Colors.green.shade800;
      case EnvironmentFlavours.developmentUnistal:
        return Colors.blue;
      case EnvironmentFlavours.productionUnistal:
        return Colors.blue;
      case EnvironmentFlavours.developmentIgl:
        return Colors.green.shade800;
      case EnvironmentFlavours.productionIgl:
        return Colors.green.shade800;
      case EnvironmentFlavours.developmentMgl:
        return Colors.green.shade800;
      case EnvironmentFlavours.productionMgl:
        return Colors.green.shade800;
      case EnvironmentFlavours.developmentOilIndia:
        return Colors.red.shade800;
      case EnvironmentFlavours.productionOilIndia:
        return Colors.red.shade800;
      case EnvironmentFlavours.developmentVPPL:
        return Colors.green.shade700;
      case EnvironmentFlavours.productionVPPL:
        return Colors.green.shade700;
      case EnvironmentFlavours.developmentVRPL:
        return Colors.amber.shade400;
      case EnvironmentFlavours.productionVRPL:
        return Colors.amber.shade400;
    }
  }

  Color get secondaryTheme {
    switch (flavours) {
      case EnvironmentFlavours.productionPurvaBharti:
        return Colors.yellow.shade800;
      case EnvironmentFlavours.developmentPurvaBharti:
        return Colors.yellow.shade800;
      case EnvironmentFlavours.developmentUnistal:
        return Colors.blue;
      case EnvironmentFlavours.productionUnistal:
        return Colors.blue;
      case EnvironmentFlavours.developmentIgl:
        return Colors.yellow.shade800;
      case EnvironmentFlavours.productionIgl:
        return Colors.yellow.shade800;
      case EnvironmentFlavours.developmentMgl:
        return Colors.yellow.shade800;
      case EnvironmentFlavours.productionMgl:
        return Colors.yellow.shade800;
      case EnvironmentFlavours.developmentOilIndia:
        return Colors.red.shade800;
      case EnvironmentFlavours.productionOilIndia:
        return Colors.red.shade800;
      case EnvironmentFlavours.developmentVPPL:
        return Colors.red.shade700;
      case EnvironmentFlavours.productionVPPL:
        return Colors.red.shade700;
      case EnvironmentFlavours.developmentVRPL:
        return Colors.amber.shade400;
      case EnvironmentFlavours.productionVRPL:
        return Colors.amber.shade400;
    }
  }
}

enum EnvironmentFlavours {
  developmentUnistal,
  productionUnistal,
  developmentPurvaBharti,
  productionPurvaBharti,
  developmentIgl,
  productionIgl,
  developmentMgl,
  productionMgl,
  developmentOilIndia,
  productionOilIndia,
  developmentVPPL,
  productionVPPL,
  developmentVRPL,
  productionVRPL,
}

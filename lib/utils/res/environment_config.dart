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
      case EnvironmentFlavours.prodUnistal:
        return "https://unistaldev.plcms.net/";
      case EnvironmentFlavours.prodPBGPL:
        return "https://pbgpl.smartgasnet.com/";
      case EnvironmentFlavours.prodIGL:
        return "https://igl.smartgasnet.com/";
      case EnvironmentFlavours.prodMGL:
        return "https://mgl.smartgasnet.com/";
      case EnvironmentFlavours.prodHPOIL:
        return "https://hpoil.smartgasnet.com/";
      case EnvironmentFlavours.prodVPPL:
        return "https://vppl.plcms.net/";
      case EnvironmentFlavours.prodVRPL:
        return "https://vrpl.plcms.net/";
      case EnvironmentFlavours.prodGJPL:
        return "https://gjpl.plcms.net/";
      case EnvironmentFlavours.prodJDPL:
        return "https://jdpl.plcms.net/";
      case EnvironmentFlavours.prodBCPL:
        return "https://bcpl.plcms.net/";
      case EnvironmentFlavours.prodAGCL:
        return "https://agcl.smartgasnet.com/";
        throw UnimplementedError();
    }
  }

  Color get primaryTheme {
    switch (flavours) {
      case EnvironmentFlavours.prodPBGPL:
        return Colors.green.shade800;
      case EnvironmentFlavours.prodUnistal:
        return Colors.blue;
      case EnvironmentFlavours.prodIGL:
        return Colors.green.shade800;
      case EnvironmentFlavours.prodMGL:
        return Colors.green.shade800;
      case EnvironmentFlavours.prodHPOIL:
        return Colors.green.shade800;
      case EnvironmentFlavours.prodVPPL:
        return Colors.green.shade700;
      case EnvironmentFlavours.prodVRPL:
        return Colors.amber.shade400;
      case EnvironmentFlavours.prodGJPL:
        return Colors.green.shade700;
      case EnvironmentFlavours.prodJDPL:
        return Colors.amber.shade400;
      case EnvironmentFlavours.prodBCPL:
        return Colors.amber.shade400;
      case EnvironmentFlavours.prodAGCL:
        return Colors.blue.shade800;
    }
  }

  Color get secondaryTheme {
    switch (flavours) {
      case EnvironmentFlavours.prodPBGPL:
        return Colors.yellow.shade800;
      case EnvironmentFlavours.prodUnistal:
        return Colors.blue;
      case EnvironmentFlavours.prodIGL:
        return Colors.yellow.shade800;
      case EnvironmentFlavours.prodMGL:
        return Colors.yellow.shade800;
      case EnvironmentFlavours.prodHPOIL:
        return Colors.green.shade800;
      case EnvironmentFlavours.prodVPPL:
        return Colors.green.shade700;
      case EnvironmentFlavours.prodVRPL:
        return Colors.amber.shade400;
      case EnvironmentFlavours.prodGJPL:
        return Colors.green.shade700;
      case EnvironmentFlavours.prodJDPL:
        return Colors.amber.shade400;
      case EnvironmentFlavours.prodBCPL:
        return Colors.amber.shade400;
      case EnvironmentFlavours.prodAGCL:
        return Colors.blue.shade800;
    }
  }
}

enum EnvironmentFlavours {
  prodUnistal,
  prodPBGPL,
  prodIGL,
  prodMGL,
  prodHPOIL,
  prodVPPL,
  prodVRPL,
  prodGJPL,
  prodJDPL,
  prodBCPL,
  prodAGCL,
}

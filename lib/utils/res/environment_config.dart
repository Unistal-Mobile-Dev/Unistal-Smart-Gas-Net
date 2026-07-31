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
      case EnvironmentFlavours.prodDBPL:
        return "https://dbpl.plcms.net/";
      case EnvironmentFlavours.prodPJPL:
        return "https://pjpl.plcms.net/";
      case EnvironmentFlavours.prodUrjagati:
       // return "https://urjagati.smartgasnet.com/";
        return "https://urjagatidev.smartgasnet.com/";
      case EnvironmentFlavours.prodHPCL:
        return "https://hpcl.smartgasnet.com/";
      case EnvironmentFlavours.prodBJPL:
        return "https://bjpl.plcms.net/";
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
        return Color(0xFFF5C400);
      case EnvironmentFlavours.prodGJPL:
        return Colors.green.shade700;
      case EnvironmentFlavours.prodJDPL:
        return Color(0xFFF5C400);
      case EnvironmentFlavours.prodBCPL:
        return Color(0xFFF5C400);
      case EnvironmentFlavours.prodAGCL:
        return Color(0xFFF5C400);
      case EnvironmentFlavours.prodDBPL:
       return Color(0xFFF5C400);
      case EnvironmentFlavours.prodPJPL:
        return Color(0xFFE04A1F);
      case EnvironmentFlavours.prodUrjagati:
        return Colors.blue.shade800;
      case EnvironmentFlavours.prodHPCL:
        return Color(0xFF1A237E);
      case EnvironmentFlavours.prodBJPL:
        return Color(0xFFF5C400);
    }
  }

  Color get secondaryTheme {
    switch (flavours) {
      case EnvironmentFlavours.prodPBGPL:
        return Color(0xFFF5C400);
      case EnvironmentFlavours.prodUnistal:
        return Colors.blue;
      case EnvironmentFlavours.prodIGL:
        return Color(0xFFF5C400);
      case EnvironmentFlavours.prodMGL:
        return Color(0xFFF5C400);
      case EnvironmentFlavours.prodHPOIL:
        return Colors.green.shade800;
      case EnvironmentFlavours.prodVPPL:
        return Colors.green.shade700;
      case EnvironmentFlavours.prodVRPL:
        return Color(0xFFF5C400);
      case EnvironmentFlavours.prodGJPL:
        return Colors.green.shade700;
      case EnvironmentFlavours.prodJDPL:
        return Color(0xFFF5C400);
      case EnvironmentFlavours.prodBCPL:
        return Color(0xFFF5C400);
      case EnvironmentFlavours.prodAGCL:
        return Colors.blue.shade800;
      case EnvironmentFlavours.prodDBPL:
        return Color(0xFF1E1E1E);
      case EnvironmentFlavours.prodPJPL:
        return Color(0xFFE04A1F);
      case EnvironmentFlavours.prodUrjagati:
        return Colors.orange.shade800;
      case EnvironmentFlavours.prodHPCL:
        return Color(0xFFC62828);
      case EnvironmentFlavours.prodBJPL:
        return Color(0xFFF5C400);
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
  prodBJPL,
  prodAGCL,
  prodDBPL,
  prodPJPL,
  prodUrjagati,
  prodHPCL,
}

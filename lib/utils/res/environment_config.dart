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
        return "http://unistal.smartgasnet.com/";
      case EnvironmentFlavours.productionUnistal:
        return "http://unistal.smartgasnet.com/";
      case EnvironmentFlavours.developmentPurvaBharti:
        return "https://nmpplstations1.smartgasnet.com/";
      case EnvironmentFlavours.productionPurvaBharti:
        return "https://pbgpl.smartgasnet.com/";
      case EnvironmentFlavours.developmentIgl:
        return "https://igl.smartgasnet.com/";
      case EnvironmentFlavours.productionIgl:
        return "https://igl.smartgasnet.com/";
    }
  }
}

enum EnvironmentFlavours {
  developmentUnistal,
  productionUnistal,
  developmentPurvaBharti,
  productionPurvaBharti,
  developmentIgl,
  productionIgl
}

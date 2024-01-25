import 'package:flutter/material.dart';

@immutable
class EnvironmentConfig extends InheritedWidget {

  final EnvironmentFlavours flavours;

  const EnvironmentConfig({super.key,
    required this.flavours,
    required Widget child,
  }): super(child: child);


  static EnvironmentConfig? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw false;
  }

  String get generalUrlBaseOnFlavour {
    switch(flavours){
      case EnvironmentFlavours.developmentUnistal:
        return "http://unistal.smartgasnet.com/";
      case EnvironmentFlavours.productionUnistal:
      return "http://unistal.smartgasnet.com/";
      case EnvironmentFlavours.developmentPurvaBharti:
        return "http://unistal.smartgasnet.com/";
      case EnvironmentFlavours.productionPurvaBharti:
        return "http://unistal.smartgasnet.com/";
    }
  }

}



enum EnvironmentFlavours{ developmentUnistal, productionUnistal, developmentPurvaBharti, productionPurvaBharti }

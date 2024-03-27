import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/backfilling/addBackFilling/domain/model/padding_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/holidy_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/bending/addBending/domain/model/visual_checks_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/concreteCoating/addConcreteCoating/domain/model/thickness_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/crossing/addCrossing/domain/model/crossing_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/coating_type_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/jointCoating/addJointCoating/domain/model/pipe_material_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/lowering/addLowering/domain/model/pipe_dia_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/alignment_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/routeSurvey/addRouteSurvey/domain/model/weather_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/stringing/addStringing/domain/model/pipe_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/trenChing/addTrenChing/domain/model/joint_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/welding/addWelding/domain/model/joint_type_model.dart';

abstract class AddDptEvent extends Equatable {
  const AddDptEvent();
}

class AddDptPageLoadEvent extends AddDptEvent {
  final BuildContext context;
  const AddDptPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddDptSelectDateEvent extends AddDptEvent {
  final BuildContext context;
  const AddDptSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddDptCalibarationDataEvent extends AddDptEvent {
  final BuildContext context;
  const AddDptCalibarationDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddDptSelectAlignmentEvent extends AddDptEvent {
  final AlignmentModel  alignmentData;
  const AddDptSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}


class AddDptSelectHolidayDataEvent extends AddDptEvent {
  final HolidayChecksModel holidayChecksData;
  const AddDptSelectHolidayDataEvent({required this.holidayChecksData});
  @override
  List<Object?> get props => [holidayChecksData];
}

class AddDptSelectDptTypeDataEvent extends AddDptEvent {
  final CrossingTypeModel dptTypeData;
  const AddDptSelectDptTypeDataEvent({required this.dptTypeData});
  @override
  List<Object?> get props => [dptTypeData];
}

class AddDptSelectCoatingTypeDataEvent extends AddDptEvent {
  final CoatingTypeModel coatingTypeData;
  const AddDptSelectCoatingTypeDataEvent({required this.coatingTypeData});
  @override
  List<Object?> get props => [coatingTypeData];
}

class AddDptSelectPipeDataEvent extends AddDptEvent {
  final PipeModel pipeData;
  const AddDptSelectPipeDataEvent({required this.pipeData});
  @override
  List<Object?> get props => [pipeData];
}

class AddDptSearchPipeDataEvent extends AddDptEvent {
  final String keyword;
  final BuildContext context;
  const AddDptSearchPipeDataEvent({required this.keyword, required this.context});
  @override
  List<Object?> get props => [keyword, context];
}

class AddDptSelectPrePaddingDataEvent extends AddDptEvent {
  final PaddingModel prePaddingData;
  const AddDptSelectPrePaddingDataEvent({required this.prePaddingData});
  @override
  List<Object?> get props => [prePaddingData];
}

class AddDptSelectPostPaddingDataEvent extends AddDptEvent {
  final PaddingModel postPaddingData;
  const AddDptSelectPostPaddingDataEvent({required this.postPaddingData});
  @override
  List<Object?> get props => [postPaddingData];
}

class AddDptSelectPipeMaterialDataEvent extends AddDptEvent {
  final PipeMaterialModel pipeMaterialData;
  const AddDptSelectPipeMaterialDataEvent({required this.pipeMaterialData});
  @override
  List<Object?> get props => [pipeMaterialData];
}
class AddDptSelectVisualChecksDataEvent extends AddDptEvent {
  final VisualChecksModel visualChecksData;
  const AddDptSelectVisualChecksDataEvent({required this.visualChecksData});
  @override
  List<Object?> get props => [visualChecksData];
}


class AddDptSelectFromJointDataEvent extends AddDptEvent {
  final JointNumberModel jointNumberData;
  const AddDptSelectFromJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddDptSelectJointTypeDataEvent extends AddDptEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddDptSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddDptSelectToJointDataEvent extends AddDptEvent {
  final JointNumberModel jointNumberData;
  const AddDptSelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddDptAddImageEvent extends AddDptEvent {
  final BuildContext context;
  final int mediaType;
  const AddDptAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddDptEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}

class AddDptSelectPipeDiaDataEvent extends AddDptEvent {
  final PipeDiaModel pipeDiaData;
  const AddDptSelectPipeDiaDataEvent({required this.pipeDiaData});
  @override
  List<Object?> get props => [pipeDiaData];
}

class AddDptSelectThicknessDataEvent extends AddDptEvent {
  final ThicknessModel thicknessData;
  const AddDptSelectThicknessDataEvent({required this.thicknessData});
  @override
  List<Object?> get props => [thicknessData];
}

class AddDptSubmitDataEvent extends AddDptEvent {
  final BuildContext context;
  const AddDptSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
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


abstract class AddDptState extends Equatable {
  const AddDptState();
}

class AddDptInitial extends AddDptState {
  @override
  List<Object> get props => [];
}

class AddDptPageLoadState extends AddDptInitial {
  @override
  List<Object> get props => [];
}

class FetchAddDptDataState extends AddDptInitial {
  final List<AlignmentModel> alignmentList;
  final AlignmentModel  alignmentData;
  final bool isLoader;
  final TextEditingController dateController;
  final TextEditingController activityRemarkController;
  final TextEditingController sectionLengthController;
  final TextEditingController casingPipeLengthController;
  final TextEditingController concreteCoatingLengthController;
  final TextEditingController dptTestController;
  final TextEditingController crossingNameController;
  final TextEditingController locationController;
  final TextEditingController holidayTestNoController;
  final TextEditingController electrometerNoController;
  final TextEditingController batchNoController;
  final TextEditingController surfaceController;
  final TextEditingController onBodyController;
  final TextEditingController onWeldController;
  final HolidayChecksModel holidayChecksData;
  final List<HolidayChecksModel> holidayCheckList;
  final JointNumberModel fromJointData;
  final List<JointNumberModel> jointFromList;
  final List<JointNumberModel> jointToList;
  final JointNumberModel toJointData;
  final List<JointTypeModel> jointTypeList;
  final JointTypeModel jointTypeData;
  final bool isJointNumberLoader;
  final File file;
  final List<WeatherModel> weatherList;
  final WeatherModel weatherData;
  final List<ThicknessModel> thicknessList;
  final ThicknessModel thicknessData;
  final List<PipeDiaModel> pipeDialList;
  final PipeDiaModel pipeDiaData;
  final List<CoatingTypeModel> coatingTypeList;
  final CoatingTypeModel coatingTypeData;
  final List<PaddingModel > prePaddingList;
  final PaddingModel prePaddingData;
  final List<PaddingModel > postPaddingList;
  final PaddingModel postPaddingData;
  final List<PipeMaterialModel> pipeMaterialList;
  final PipeMaterialModel pipeMaterialData;
  final List<VisualChecksModel> visualsChecksList;
  final VisualChecksModel visualChecksData;
  final List<CrossingTypeModel> dptTyeList;
  final CrossingTypeModel dptTypeData;
  final List<PipeModel> pipeList;
  final List<dynamic> searchPipeList;
  final bool searchPipeLoader;
  final TextEditingController searchPipeController;

  FetchAddDptDataState({
    required this.isLoader,
    required this.alignmentList,
    required this.dateController,
    required this.activityRemarkController,
    required this.onWeldController,
    required this.sectionLengthController,
    required this.casingPipeLengthController,
    required this.batchNoController,
    required this.alignmentData,
    required this.file,
    required this.weatherList,
    required this.weatherData,
    required this.jointTypeData,
    required this.jointTypeList,
    required this.isJointNumberLoader,
    required this.fromJointData,
    required this.jointFromList,
    required this.jointToList,
    required this.concreteCoatingLengthController,
    required this.locationController,
    required this.toJointData,
    required this.holidayTestNoController,
    required this.holidayChecksData,
    required this.onBodyController,
    required this.holidayCheckList,
    required this.electrometerNoController,
    required this.crossingNameController,
    required this.surfaceController,
    required this.thicknessData,
    required this.thicknessList,
    required this.pipeDiaData,
    required this.pipeDialList,
    required this.coatingTypeData,
    required this.coatingTypeList,
    required this.prePaddingData,
    required this.prePaddingList,
    required this.pipeMaterialData,
    required this.pipeMaterialList,
    required this.visualChecksData,
    required this.visualsChecksList,
    required this.dptTypeData,
    required this.dptTyeList,
    required this.postPaddingData,
    required this.postPaddingList,
    required this.dptTestController,
    required this.searchPipeLoader,
    required this.pipeList,
    required this.searchPipeController,
    required this.searchPipeList,
  });

  @override
  List<Object> get props => [
    isLoader,
    alignmentList,
    dateController,
    activityRemarkController,
    onWeldController,
    sectionLengthController,
    casingPipeLengthController,
    batchNoController,
    alignmentData,
    file,
    weatherList,
    weatherData,
    jointTypeData,
    jointTypeList,
    isJointNumberLoader,
    fromJointData,
    jointFromList,
    jointToList,
    concreteCoatingLengthController,
    locationController,
    toJointData,
    holidayTestNoController,
    holidayChecksData,
    onBodyController,
    holidayCheckList,
    electrometerNoController,
    crossingNameController,
    surfaceController,
    thicknessData,
    thicknessList,
    pipeDiaData,
    pipeDialList,
    coatingTypeData,
    coatingTypeList,
    prePaddingData,
    prePaddingList,
    pipeMaterialList,
    pipeMaterialData,
    visualChecksData,
    visualsChecksList,
    dptTyeList,
    dptTypeData,
    postPaddingData,
    postPaddingList,
    dptTestController,
    searchPipeLoader,
    pipeList,
    searchPipeController,
    searchPipeList,
  ];
}

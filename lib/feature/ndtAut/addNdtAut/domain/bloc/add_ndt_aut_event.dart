part of 'add_ndt_aut_bloc.dart';

abstract class AddNdtAutEvent extends Equatable {
  const AddNdtAutEvent();
}

class AddNdtAutLoadEvent extends AddNdtAutEvent {
  final BuildContext context;

  const AddNdtAutLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddNdtAutSelectDateEvent extends AddNdtAutEvent {
  final BuildContext context;

  const AddNdtAutSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddNdtAutSelectAlignmentEvent extends AddNdtAutEvent {
  final AlignmentModel alignmentData;

  const AddNdtAutSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddNdtAutMultipleSelectAlignmentEvent extends AddNdtAutEvent {
  final List<AlignmentModel> alignmentData;

  const AddNdtAutMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddNdtAutSelectWelderEvent extends AddNdtAutEvent {
  final List<WelderModel> selectedWelderList;

  const AddNdtAutSelectWelderEvent({required this.selectedWelderList});

  @override
  List<Object?> get props => [selectedWelderList];
}

class AddNdtAutSelectWPSTypeEvent extends AddNdtAutEvent {
  final WPSModel wpsTypeData;
  final BuildContext context;

  const AddNdtAutSelectWPSTypeEvent(
      {required this.wpsTypeData, required this.context});

  @override
  List<Object?> get props => [wpsTypeData, context];
}

class AddNdtAutSelectAutDataEvent extends AddNdtAutEvent {
  final AutStatusModel autStatusData;

  const AddNdtAutSelectAutDataEvent({required this.autStatusData});

  @override
  List<Object?> get props => [autStatusData];
}

class AddNdtAutSelectDefectLayerEvent extends AddNdtAutEvent {
  final List<DefectLayerModel> selectedDefectLayer;

  const AddNdtAutSelectDefectLayerEvent({required this.selectedDefectLayer});

  @override
  List<Object?> get props => [selectedDefectLayer];
}

class AddNdtAutSelectDefectTypeEvent extends AddNdtAutEvent {
  final List<DefectTypeModel> selectedDefectType;
  const AddNdtAutSelectDefectTypeEvent({required this.selectedDefectType});
  @override
  List<Object?> get props => [selectedDefectType];
}

class AddNdtAutSelectJointTypeEvent extends AddNdtAutEvent {
  final JointTypeModel jointTypeModel;
  final BuildContext context;

  const AddNdtAutSelectJointTypeEvent(
      {required this.jointTypeModel, required this.context});

  @override
  List<Object?> get props => [jointTypeModel, context];
}

class AddNdtAutSelectJointNumberEvent extends AddNdtAutEvent {
  final JointNumberModel jointNumberData;

  const AddNdtAutSelectJointNumberEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddNdtAutAddImageEvent extends AddNdtAutEvent {
  final BuildContext context;
  final int mediaType;

  const AddNdtAutAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddNdtAutEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddNdtAutSubmitDataEvent extends AddNdtAutEvent {
  final BuildContext context;

  const AddNdtAutSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

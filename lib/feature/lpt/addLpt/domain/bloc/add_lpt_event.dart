part of 'add_lpt_bloc.dart';

abstract class AddLptEvent extends Equatable {
  const AddLptEvent();
}

class AddLptPageLoadEvent extends AddLptEvent {
  final BuildContext context;

  const AddLptPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddLptSelectDateEvent extends AddLptEvent {
  final BuildContext context;

  const AddLptSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddLptSelectAlignmentEvent extends AddLptEvent {
  final AlignmentModel alignmentData;

  const AddLptSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddLptMultipleSelectAlignmentEvent extends AddLptEvent {
  final List<AlignmentModel> alignmentData;

  const AddLptMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddLptSelectJointTypeDataEvent extends AddLptEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;

  const AddLptSelectJointTypeDataEvent(
      {required this.jointTypeData, required this.context});

  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddLptSelectJointDataEvent extends AddLptEvent {
  final JointNumberModel jointNumberData;

  const AddLptSelectJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddLptSelectLptStatusDataEvent extends AddLptEvent {
  final LptStatusModel lptStatusData;

  const AddLptSelectLptStatusDataEvent({required this.lptStatusData});

  @override
  List<Object?> get props => [lptStatusData];
}

class AddLptAddImageEvent extends AddLptEvent {
  final BuildContext context;
  final int mediaType;

  const AddLptAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddLptEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddLptSearchPipeDataEvent extends AddLptEvent {
  final BuildContext context;
  final String keyword;

  const AddLptSearchPipeDataEvent(
      {required this.context, required this.keyword});

  @override
  List<Object?> get props => [context, keyword];
}

class AddLptSelectPipeDataEvent extends AddLptEvent {
  final PipeModel pipeData;

  const AddLptSelectPipeDataEvent({required this.pipeData});

  @override
  List<Object?> get props => [pipeData];
}

class AddLptSelectPipeThicknessEvent extends AddLptEvent {
  final ThicknessModel pipeThicknessData;

  const AddLptSelectPipeThicknessEvent({required this.pipeThicknessData});

  @override
  List<Object?> get props => [pipeThicknessData];
}

class AddLptSubmitDataEvent extends AddLptEvent {
  final BuildContext context;

  const AddLptSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
class SelectMEILEvent extends AddLptEvent {
  final TerrainTypeModel meilData;
  const SelectMEILEvent({required this.meilData});
  @override
  List<Object?> get props => [meilData];
}

class SelectCEILEvent extends AddLptEvent {
  final TerrainTypeModel ceilVal;
  const SelectCEILEvent({required this.ceilVal});
  @override
  List<Object?> get props => [ceilVal];
}

class SelectMECONEvent extends AddLptEvent {
  final TerrainTypeModel meconeVal;
  const SelectMECONEvent({required this.meconeVal});
  @override
  List<Object?> get props => [meconeVal];
}
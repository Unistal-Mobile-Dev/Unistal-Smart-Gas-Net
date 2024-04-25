part of 'add_marker_bloc.dart';

abstract class AddMarkerEvent extends Equatable {
  const AddMarkerEvent();
}

class AddMarkerPageLoadEvent extends AddMarkerEvent {
  final BuildContext context;
  const AddMarkerPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddMarkerSelectDateEvent extends AddMarkerEvent {
  final BuildContext context;
  const AddMarkerSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddMarkerCalibarationDataEvent extends AddMarkerEvent {
  final BuildContext context;
  const AddMarkerCalibarationDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddMarkerSelectAlignmentEvent extends AddMarkerEvent {
  final AlignmentModel  alignmentData;
  const AddMarkerSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddMarkerSelectMarkerEvent extends AddMarkerEvent {
  final MarkerTypeModel  markerTypeData;
  const AddMarkerSelectMarkerEvent({required this.markerTypeData});
  @override
  List<Object?> get props => [markerTypeData];
}


class AddMarkerSelectHolidayDataEvent extends AddMarkerEvent {
  final HolidayChecksModel holidayChecksData;
  const AddMarkerSelectHolidayDataEvent({required this.holidayChecksData});
  @override
  List<Object?> get props => [holidayChecksData];
}

class AddMarkerSelectCoatingTypeDataEvent extends AddMarkerEvent {
  final CoatingTypeModel coatingTypeData;
  const AddMarkerSelectCoatingTypeDataEvent({required this.coatingTypeData});
  @override
  List<Object?> get props => [coatingTypeData];
}

class AddMarkerSelectPeelTestDataEvent extends AddMarkerEvent {
  final PaddingModel peelTestData;
  const AddMarkerSelectPeelTestDataEvent({required this.peelTestData});
  @override
  List<Object?> get props => [peelTestData];
}

class AddMarkerSelectPipeMaterialDataEvent extends AddMarkerEvent {
  final PipeMaterialModel pipeMaterialData;
  const AddMarkerSelectPipeMaterialDataEvent({required this.pipeMaterialData});
  @override
  List<Object?> get props => [pipeMaterialData];
}
class AddMarkerSelectVisualChecksDataEvent extends AddMarkerEvent {
  final VisualChecksModel visualChecksData;
  const AddMarkerSelectVisualChecksDataEvent({required this.visualChecksData});
  @override
  List<Object?> get props => [visualChecksData];
}


class AddMarkerSelectFromJointDataEvent extends AddMarkerEvent {
  final JointNumberModel jointNumberData;
  const AddMarkerSelectFromJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddMarkerSelectJointTypeDataEvent extends AddMarkerEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddMarkerSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddMarkerSelectToJointDataEvent extends AddMarkerEvent {
  final JointNumberModel jointNumberData;
  const AddMarkerSelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddMarkerAddImageEvent extends AddMarkerEvent {
  final BuildContext context;
  final int mediaType;
  const AddMarkerAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddMarkerEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}

class AddMarkerSelectPipeDiaDataEvent extends AddMarkerEvent {
  final PipeDiaModel pipeDiaData;
  const AddMarkerSelectPipeDiaDataEvent({required this.pipeDiaData});
  @override
  List<Object?> get props => [pipeDiaData];
}

class AddMarkerSelectThicknessDataEvent extends AddMarkerEvent {
  final ThicknessModel coatingThicknessData;
  const AddMarkerSelectThicknessDataEvent({required this.coatingThicknessData});
  @override
  List<Object?> get props => [coatingThicknessData];
}

class AddMarkerSelectPipeThicknessDataEvent extends AddMarkerEvent {
  final ThicknessModel thicknessData;
  const AddMarkerSelectPipeThicknessDataEvent({required this.thicknessData});
  @override
  List<Object?> get props => [thicknessData];
}

class AddMarkerSelectSpreadEvent extends AddMarkerEvent {
  final SpreadTypeModel  spreadTypeData;
  const AddMarkerSelectSpreadEvent({required this.spreadTypeData});
  @override
  List<Object?> get props => [spreadTypeData];
}

class AddMarkerSelectSectionEvent extends AddMarkerEvent {
  final SectionTypeModel  sectionTypeData;
  const AddMarkerSelectSectionEvent({required this.sectionTypeData});
  @override
  List<Object?> get props => [sectionTypeData];
}

class AddMarkerSubmitDataEvent extends AddMarkerEvent {
  final BuildContext context;
  const AddMarkerSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
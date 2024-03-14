part of 'add_crossing_bloc.dart';

abstract class AddCrossingEvent extends Equatable {
  const AddCrossingEvent();
}

class AddCrossingPageLoadEvent extends AddCrossingEvent {
  final BuildContext context;
  const AddCrossingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddCrossingSelectDateEvent extends AddCrossingEvent {
  final BuildContext context;
  const AddCrossingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddCrossingCalibarationDataEvent extends AddCrossingEvent {
  final BuildContext context;
  const AddCrossingCalibarationDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddCrossingSelectAlignmentEvent extends AddCrossingEvent {
  final AlignmentModel  alignmentData;
  const AddCrossingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}


class AddCrossingSelectHolidayDataEvent extends AddCrossingEvent {
  final HolidayChecksModel holidayChecksData;
  const AddCrossingSelectHolidayDataEvent({required this.holidayChecksData});
  @override
  List<Object?> get props => [holidayChecksData];
}

class AddCrossingSelectCrossingTypeDataEvent extends AddCrossingEvent {
  final CrossingTypeModel crossingTypeData;
  const AddCrossingSelectCrossingTypeDataEvent({required this.crossingTypeData});
  @override
  List<Object?> get props => [crossingTypeData];
}

class AddCrossingSelectCoatingTypeDataEvent extends AddCrossingEvent {
  final CoatingTypeModel coatingTypeData;
  const AddCrossingSelectCoatingTypeDataEvent({required this.coatingTypeData});
  @override
  List<Object?> get props => [coatingTypeData];
}

class AddCrossingSelectPrePaddingDataEvent extends AddCrossingEvent {
  final PaddingModel prePaddingData;
  const AddCrossingSelectPrePaddingDataEvent({required this.prePaddingData});
  @override
  List<Object?> get props => [prePaddingData];
}

class AddCrossingSelectPostPaddingDataEvent extends AddCrossingEvent {
  final PaddingModel postPaddingData;
  const AddCrossingSelectPostPaddingDataEvent({required this.postPaddingData});
  @override
  List<Object?> get props => [postPaddingData];
}

class AddCrossingSelectPipeMaterialDataEvent extends AddCrossingEvent {
  final PipeMaterialModel pipeMaterialData;
  const AddCrossingSelectPipeMaterialDataEvent({required this.pipeMaterialData});
  @override
  List<Object?> get props => [pipeMaterialData];
}
class AddCrossingSelectVisualChecksDataEvent extends AddCrossingEvent {
  final VisualChecksModel visualChecksData;
  const AddCrossingSelectVisualChecksDataEvent({required this.visualChecksData});
  @override
  List<Object?> get props => [visualChecksData];
}


class AddCrossingSelectFromJointDataEvent extends AddCrossingEvent {
  final JointNumberModel jointNumberData;
  const AddCrossingSelectFromJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddCrossingSelectJointTypeDataEvent extends AddCrossingEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddCrossingSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddCrossingSelectToJointDataEvent extends AddCrossingEvent {
  final JointNumberModel jointNumberData;
  const AddCrossingSelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddCrossingAddImageEvent extends AddCrossingEvent {
  final BuildContext context;
  final int mediaType;
  const AddCrossingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddCrossingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}

class AddCrossingSelectPipeDiaDataEvent extends AddCrossingEvent {
  final PipeDiaModel pipeDiaData;
  const AddCrossingSelectPipeDiaDataEvent({required this.pipeDiaData});
  @override
  List<Object?> get props => [pipeDiaData];
}

class AddCrossingSelectThicknessDataEvent extends AddCrossingEvent {
  final ThicknessModel thicknessData;
  const AddCrossingSelectThicknessDataEvent({required this.thicknessData});
  @override
  List<Object?> get props => [thicknessData];
}

class AddCrossingSubmitDataEvent extends AddCrossingEvent {
  final BuildContext context;
  const AddCrossingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
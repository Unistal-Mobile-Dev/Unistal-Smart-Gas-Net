part of 'add_joint_coating_bloc.dart';

abstract class AddJointCoatingEvent extends Equatable {
  const AddJointCoatingEvent();
}

class AddJointCoatingPageLoadEvent extends AddJointCoatingEvent {
  final BuildContext context;
  const AddJointCoatingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddJointCoatingSelectDateEvent extends AddJointCoatingEvent {
  final BuildContext context;
  const AddJointCoatingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddJointCoatingCalibarationDataEvent extends AddJointCoatingEvent {
  final BuildContext context;
  const AddJointCoatingCalibarationDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddJointCoatingSelectAlignmentEvent extends AddJointCoatingEvent {
  final AlignmentModel  alignmentData;
  const AddJointCoatingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}


class AddJointCoatingSelectHolidayDataEvent extends AddJointCoatingEvent {
  final HolidayChecksModel holidayChecksData;
  const AddJointCoatingSelectHolidayDataEvent({required this.holidayChecksData});
  @override
  List<Object?> get props => [holidayChecksData];
}

class AddJointCoatingSelectCoatingTypeDataEvent extends AddJointCoatingEvent {
  final CoatingTypeModel coatingTypeData;
  const AddJointCoatingSelectCoatingTypeDataEvent({required this.coatingTypeData});
  @override
  List<Object?> get props => [coatingTypeData];
}

class AddJointCoatingSelectPeelTestDataEvent extends AddJointCoatingEvent {
  final PaddingModel peelTestData;
  const AddJointCoatingSelectPeelTestDataEvent({required this.peelTestData});
  @override
  List<Object?> get props => [peelTestData];
}

class AddJointCoatingSelectPipeMaterialDataEvent extends AddJointCoatingEvent {
  final PipeMaterialModel pipeMaterialData;
  const AddJointCoatingSelectPipeMaterialDataEvent({required this.pipeMaterialData});
  @override
  List<Object?> get props => [pipeMaterialData];
}
class AddJointCoatingSelectVisualChecksDataEvent extends AddJointCoatingEvent {
  final VisualChecksModel visualChecksData;
  const AddJointCoatingSelectVisualChecksDataEvent({required this.visualChecksData});
  @override
  List<Object?> get props => [visualChecksData];
}


class AddJointCoatingSelectFromJointDataEvent extends AddJointCoatingEvent {
  final JointNumberModel jointNumberData;
  const AddJointCoatingSelectFromJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddJointCoatingSelectJointTypeDataEvent extends AddJointCoatingEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddJointCoatingSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddJointCoatingSelectToJointDataEvent extends AddJointCoatingEvent {
  final JointNumberModel jointNumberData;
  const AddJointCoatingSelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddJointCoatingAddImageEvent extends AddJointCoatingEvent {
  final BuildContext context;
  final int mediaType;
  const AddJointCoatingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddJointCoatingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}

class AddJointCoatingSelectPipeDiaDataEvent extends AddJointCoatingEvent {
  final PipeDiaModel pipeDiaData;
  const AddJointCoatingSelectPipeDiaDataEvent({required this.pipeDiaData});
  @override
  List<Object?> get props => [pipeDiaData];
}

class AddJointCoatingSelectThicknessDataEvent extends AddJointCoatingEvent {
  final ThicknessModel coatingThicknessData;
  const AddJointCoatingSelectThicknessDataEvent({required this.coatingThicknessData});
  @override
  List<Object?> get props => [coatingThicknessData];
}

class AddJointCoatingSelectPipeThicknessDataEvent extends AddJointCoatingEvent {
  final ThicknessModel thicknessData;
  const AddJointCoatingSelectPipeThicknessDataEvent({required this.thicknessData});
  @override
  List<Object?> get props => [thicknessData];
}


class AddJointCoatingSubmitDataEvent extends AddJointCoatingEvent {
  final BuildContext context;
  const AddJointCoatingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
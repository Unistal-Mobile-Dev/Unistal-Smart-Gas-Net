part of 'add_radiography_bloc.dart';

abstract class AddRadiographyEvent extends Equatable {
  const AddRadiographyEvent();
}

class AddRadiographyPageLoadEvent extends AddRadiographyEvent {
  final BuildContext context;
  const AddRadiographyPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRadiographySelectDateEvent extends AddRadiographyEvent {
  final BuildContext context;
  const AddRadiographySelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRadiographySelectAlignmentEvent extends AddRadiographyEvent {
  final AlignmentModel  alignmentData;
  const AddRadiographySelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddRadiographySelectJointTypeDataEvent extends AddRadiographyEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddRadiographySelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddRadiographySelectSegmentDataEvent extends AddRadiographyEvent {
  final int index;
  final int segmentIndex;
  const AddRadiographySelectSegmentDataEvent({required this.index, required this.segmentIndex});
  @override
  List<Object?> get props => [index, segmentIndex];
}

class AddRadiographySelectToJointDataEvent extends AddRadiographyEvent {
  final JointNumberModel jointNumberData;
  const AddRadiographySelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddRadiographyAddImageEvent extends AddRadiographyEvent {
  final BuildContext context;
  const AddRadiographyAddImageEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class SelectWeatherEvent extends AddRadiographyEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddRadiographySubmitDataEvent extends AddRadiographyEvent {
  final BuildContext context;
  const AddRadiographySubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
part of 'add_back_filling_bloc.dart';

abstract class AddBackFillingEvent extends Equatable {
  const AddBackFillingEvent();
}


class AddBackFillingPageLoadEvent extends AddBackFillingEvent {
  final BuildContext context;
  const AddBackFillingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddBackFillingSelectDateEvent extends AddBackFillingEvent {
  final BuildContext context;
  const AddBackFillingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddBackFillingSelectAlignmentEvent extends AddBackFillingEvent {
  final AlignmentModel  alignmentData;
  const AddBackFillingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddBackFillingSelectPaddingDataEvent extends AddBackFillingEvent {
  final PaddingModel paddingData;
  const AddBackFillingSelectPaddingDataEvent({required this.paddingData});
  @override
  List<Object?> get props => [paddingData];
}

class AddBackFillingSelectPlasticGratingEvent extends AddBackFillingEvent {
  final VisualChecksModel plasticGratingData;
  const AddBackFillingSelectPlasticGratingEvent({required this.plasticGratingData});
  @override
  List<Object?> get props => [plasticGratingData];
}


class AddBackFillingSelectFromJointDataEvent extends AddBackFillingEvent {
  final JointNumberModel jointNumberData;
  const AddBackFillingSelectFromJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddBackFillingSelectJointTypeDataEvent extends AddBackFillingEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddBackFillingSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddBackFillingSelectToJointDataEvent extends AddBackFillingEvent {
  final JointNumberModel jointNumberData;
  const AddBackFillingSelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddBackFillingAddImageEvent extends AddBackFillingEvent {
  final BuildContext context;
  final int mediaType;
  const AddBackFillingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddBackFillingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddBackFillingSubmitDataEvent extends AddBackFillingEvent {
  final BuildContext context;
  const AddBackFillingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
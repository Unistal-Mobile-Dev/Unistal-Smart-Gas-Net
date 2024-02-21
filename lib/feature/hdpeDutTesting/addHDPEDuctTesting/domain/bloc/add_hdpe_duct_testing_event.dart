part of 'add_hdpe_duct_testing_bloc.dart';

abstract class AddHdpeDuctTestingEvent extends Equatable {
  const AddHdpeDuctTestingEvent();
}

class AddHdpeDuctTestingPageLoadEvent extends AddHdpeDuctTestingEvent {
  final BuildContext context;
  const AddHdpeDuctTestingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddHdpeDuctTestingSelectDateEvent extends AddHdpeDuctTestingEvent {
  final BuildContext context;
  const AddHdpeDuctTestingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddHdpeDuctTestingSelectAlignmentEvent extends AddHdpeDuctTestingEvent {
  final AlignmentModel  alignmentData;
  const AddHdpeDuctTestingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}


class AddHdpeDuctTestingSelectFromJointDataEvent extends AddHdpeDuctTestingEvent {
  final JointNumberModel jointNumberData;
  const AddHdpeDuctTestingSelectFromJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddHdpeDuctTestingSelectJointTypeDataEvent extends AddHdpeDuctTestingEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddHdpeDuctTestingSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddHdpeDuctTestingSelectToJointDataEvent extends AddHdpeDuctTestingEvent {
  final JointNumberModel jointNumberData;
  const AddHdpeDuctTestingSelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddHdpeDuctTestingAddImageEvent extends AddHdpeDuctTestingEvent {
  final BuildContext context;
  final int mediaType;
  const AddHdpeDuctTestingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddHdpeDuctTestingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}

class AddHdpeDuctTestingSubmitDataEvent extends AddHdpeDuctTestingEvent {
  final BuildContext context;
  const AddHdpeDuctTestingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
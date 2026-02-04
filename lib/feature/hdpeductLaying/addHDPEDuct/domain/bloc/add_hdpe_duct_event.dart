part of 'add_hdpe_duct_bloc.dart';

abstract class AddHdpeDuctEvent extends Equatable {
  const AddHdpeDuctEvent();
}

class AddHdpeDuctPageLoadEvent extends AddHdpeDuctEvent {
  final BuildContext context;

  const AddHdpeDuctPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHdpeDuctSelectDateEvent extends AddHdpeDuctEvent {
  final BuildContext context;

  const AddHdpeDuctSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHdpeDuctSelectAlignmentEvent extends AddHdpeDuctEvent {
 final AlignmentModel alignmentData;

  const AddHdpeDuctSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddHdpeDuctMultipleSelectAlignmentEvent extends AddHdpeDuctEvent {
  final List<AlignmentModel> alignmentData;

  const AddHdpeDuctMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddHdpeDuctSelectPaddingDataEvent extends AddHdpeDuctEvent {
  final PaddingModel paddingData;

  const AddHdpeDuctSelectPaddingDataEvent({required this.paddingData});

  @override
  List<Object?> get props => [paddingData];
}

class AddHdpeDuctSelectWarningMeterDataEvent extends AddHdpeDuctEvent {
  final PaddingModel warningMeterData;

  const AddHdpeDuctSelectWarningMeterDataEvent(
      {required this.warningMeterData});

  @override
  List<Object?> get props => [warningMeterData];
}

class AddHdpeDuctSelectFromJointDataEvent extends AddHdpeDuctEvent {
  final JointNumberModel jointNumberData;

  const AddHdpeDuctSelectFromJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddHdpeDuctSelectJointTypeDataEvent extends AddHdpeDuctEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;

  const AddHdpeDuctSelectJointTypeDataEvent(
      {required this.jointTypeData, required this.context});

  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddHdpeDuctSelectToJointDataEvent extends AddHdpeDuctEvent {
  final JointNumberModel jointNumberData;

  const AddHdpeDuctSelectToJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddHdpeDuctAddImageEvent extends AddHdpeDuctEvent {
  final BuildContext context;
  final int mediaType;

  const AddHdpeDuctAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddHdpeDuctEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddHdpeDuctSubmitDataEvent extends AddHdpeDuctEvent {
  final BuildContext context;

  const AddHdpeDuctSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

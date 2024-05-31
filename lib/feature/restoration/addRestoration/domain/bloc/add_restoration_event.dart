part of 'add_restoration_bloc.dart';

abstract class AddRestorationEvent extends Equatable {
  const AddRestorationEvent();
}

class AddRestorationPageLoadEvent extends AddRestorationEvent {
  final BuildContext context;

  const AddRestorationPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddRestorationSelectDateEvent extends AddRestorationEvent {
  final BuildContext context;

  const AddRestorationSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddRestorationSelectAlignmentEvent extends AddRestorationEvent {
  final AlignmentModel alignmentData;

  const AddRestorationSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddRestorationSelectRemovalOfSurplusMaterialDataEvent
    extends AddRestorationEvent {
  final PaddingModel removalOfSurplusMaterialData;

  const AddRestorationSelectRemovalOfSurplusMaterialDataEvent(
      {required this.removalOfSurplusMaterialData});

  @override
  List<Object?> get props => [removalOfSurplusMaterialData];
}

class AddRestorationSelectReplacementofTopSoilDataEvent
    extends AddRestorationEvent {
  final PaddingModel replacementofTopSoilData;

  const AddRestorationSelectReplacementofTopSoilDataEvent(
      {required this.replacementofTopSoilData});

  @override
  List<Object?> get props => [replacementofTopSoilData];
}

class AddRestorationSelectReinstallationBoundaryStonesDataEvent
    extends AddRestorationEvent {
  final PaddingModel reinstallationBoundaryStonesData;

  const AddRestorationSelectReinstallationBoundaryStonesDataEvent(
      {required this.reinstallationBoundaryStonesData});

  @override
  List<Object?> get props => [reinstallationBoundaryStonesData];
}

class AddRestorationSelectFromJointDataEvent extends AddRestorationEvent {
  final JointNumberModel jointNumberData;

  const AddRestorationSelectFromJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddRestorationSelectJointTypeDataEvent extends AddRestorationEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;

  const AddRestorationSelectJointTypeDataEvent(
      {required this.jointTypeData, required this.context});

  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddRestorationSelectToJointDataEvent extends AddRestorationEvent {
  final JointNumberModel jointNumberData;

  const AddRestorationSelectToJointDataEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddRestorationAddImageEvent extends AddRestorationEvent {
  final BuildContext context;
  final int mediaType;

  const AddRestorationAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddRestorationEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddRestorationSubmitDataEvent extends AddRestorationEvent {
  final BuildContext context;

  const AddRestorationSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

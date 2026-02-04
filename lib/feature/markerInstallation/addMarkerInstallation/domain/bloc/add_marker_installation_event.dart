part of 'add_marker_installation_bloc.dart';

@immutable
abstract class AddMarkerInstallationEvent extends Equatable{}


class AddMarkerInstallationPageLoadEvent extends AddMarkerInstallationEvent {
  final BuildContext context;
  AddMarkerInstallationPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddMarkerInstallationSelectDateEvent extends AddMarkerInstallationEvent {
  final BuildContext context;
  AddMarkerInstallationSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddMarkerInstallationSelectAlignmentEvent extends AddMarkerInstallationEvent {
   final AlignmentModel alignmentData;
  AddMarkerInstallationSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddMarkerInstallationMultipleSelectAlignmentEvent extends AddMarkerInstallationEvent {
  final List<AlignmentModel> alignmentData;
  AddMarkerInstallationMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddMarkerInstallationAddImageEvent extends AddMarkerInstallationEvent {
  final BuildContext context;
  final int mediaType;
  AddMarkerInstallationAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddMarkerInstallationEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}


class SelectJointEvent extends AddMarkerInstallationEvent {
  final JointNumberModel jointValue;
  SelectJointEvent({required this.jointValue});
  @override
  List<Object?> get props => [jointValue];
}

class SelectMarkerTypeEvent extends AddMarkerInstallationEvent {
  final MarkerTypeModel markerTypeValue;
  SelectMarkerTypeEvent({required this.markerTypeValue});
  @override
  List<Object?> get props => [markerTypeValue];
}


class AddMarkerInstallationSubmitDataEvent extends AddMarkerInstallationEvent {
  final BuildContext context;
  AddMarkerInstallationSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}


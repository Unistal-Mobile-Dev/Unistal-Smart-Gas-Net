part of 'add_polarisation_coupan_bloc.dart';

@immutable
abstract class AddPolarisationCoupanEvent extends Equatable{}


class AddPolarisationCoupanPageLoadEvent extends AddPolarisationCoupanEvent {
  final BuildContext context;
  AddPolarisationCoupanPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPolarisationCoupanSelectDateEvent extends AddPolarisationCoupanEvent {
  final BuildContext context;
  AddPolarisationCoupanSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPolarisationCoupanSelectAlignmentEvent extends AddPolarisationCoupanEvent {
  final AlignmentModel alignmentData;
  AddPolarisationCoupanSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class SelectWeatherEvent extends AddPolarisationCoupanEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddPolarisationCoupanTLPTypeEvent extends AddPolarisationCoupanEvent {
  final TlpTypeModel tlpTypeValue;
  AddPolarisationCoupanTLPTypeEvent({required this.tlpTypeValue});

  @override
  List<Object?> get props => [tlpTypeValue];
}

class AddPolarisationCoupanCorrosionEvent extends AddPolarisationCoupanEvent {
  final VisualChecksModel corrosionValue;
  AddPolarisationCoupanCorrosionEvent({required this.corrosionValue});

  @override
  List<Object?> get props => [corrosionValue];
}

class AddPolarisationCoupanCableTerminationEvent extends AddPolarisationCoupanEvent {
  final VisualChecksModel cableTerminationValue;
  AddPolarisationCoupanCableTerminationEvent({required this.cableTerminationValue});

  @override
  List<Object?> get props => [cableTerminationValue];
}

class AddPolarisationCoupanDateCalibrationEvent extends AddPolarisationCoupanEvent {
  final BuildContext context;
  AddPolarisationCoupanDateCalibrationEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddPolarisationCoupanAddImageEvent extends AddPolarisationCoupanEvent {
  final BuildContext context;
  final int mediaType;
  AddPolarisationCoupanAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class AddPolarisationCoupanSubmitDataEvent extends AddPolarisationCoupanEvent {
  final BuildContext context;
  AddPolarisationCoupanSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}



part of 'add_zn_grounding_anode_bloc.dart';

@immutable
abstract class AddZnGroundingAnodeEvent extends Equatable {}

class AddZnGroundingAnodePageLoadEvent extends  AddZnGroundingAnodeEvent {
  final BuildContext context;
  AddZnGroundingAnodePageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddZnGroundingAnodeSelectDateEvent extends  AddZnGroundingAnodeEvent {
  final BuildContext context;
  AddZnGroundingAnodeSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddZnGroundingAnodeSelectAlignmentEvent extends  AddZnGroundingAnodeEvent {
 final AlignmentModel alignmentData;
  AddZnGroundingAnodeSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class  AddZnGroundingAnodeMultipleSelectAlignmentEvent extends  AddZnGroundingAnodeEvent {
  final List<AlignmentModel> alignmentData;
  AddZnGroundingAnodeMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class SelectWeatherEvent extends  AddZnGroundingAnodeEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddTestStationBoxTLPTypeEvent extends AddZnGroundingAnodeEvent {
  final TlpTypeModel tlpTypeValue;
  AddTestStationBoxTLPTypeEvent({required this.tlpTypeValue});

  @override
  List<Object?> get props => [tlpTypeValue];
}


class SelectJointTypeDataEvent extends AddZnGroundingAnodeEvent {
  final JointTypeModel jointTypeDataValue;
  final BuildContext context;
  SelectJointTypeDataEvent({required this.jointTypeDataValue, required this.context});

  @override
  List<Object?> get props => [jointTypeDataValue, context];
}

class SelectJointEvent extends AddZnGroundingAnodeEvent {
  final JointNumberModel jointValue;
  SelectJointEvent({required this.jointValue});
  @override
  List<Object?> get props => [jointValue];
}

class AddTestStationBoxSacrificialAnodeTypeEvent extends AddZnGroundingAnodeEvent {
  final TlpTypeModel typeNodeValue;
  AddTestStationBoxSacrificialAnodeTypeEvent({required this.typeNodeValue});

  @override
  List<Object?> get props => [typeNodeValue];
}

class  AddZnGroundingAnodeAddImageEvent extends  AddZnGroundingAnodeEvent {
  final BuildContext context;
  final int mediaType;
  AddZnGroundingAnodeAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class  AddZnGroundingAnodeSubmitDataEvent extends  AddZnGroundingAnodeEvent {
  final BuildContext context;
  AddZnGroundingAnodeSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
part of 'add_sacrificial_anode_bloc.dart';

@immutable
abstract class AddSacrificialAnodeEvent extends Equatable{}


class  AddSacrificialAnodePageLoadEvent extends  AddSacrificialAnodeEvent {
  final BuildContext context;
   AddSacrificialAnodePageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddSacrificialAnodeSelectDateEvent extends  AddSacrificialAnodeEvent {
  final BuildContext context;
   AddSacrificialAnodeSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class  AddSacrificialAnodeSelectAlignmentEvent extends  AddSacrificialAnodeEvent {
  final AlignmentModel alignmentData;
   AddSacrificialAnodeSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class SelectWeatherEvent extends  AddSacrificialAnodeEvent {
  final WeatherModel weatherData;
  SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}


class AddTestStationBoxTLPTypeEvent extends AddSacrificialAnodeEvent {
  final TlpTypeModel tlpTypeValue;
  AddTestStationBoxTLPTypeEvent({required this.tlpTypeValue});

  @override
  List<Object?> get props => [tlpTypeValue];
}

class AddTestStationBoxSacrificialAnodeTypeEvent extends AddSacrificialAnodeEvent {
  final TlpTypeModel sacrificialAnodeValue;
  AddTestStationBoxSacrificialAnodeTypeEvent({required this.sacrificialAnodeValue});

  @override
  List<Object?> get props => [sacrificialAnodeValue];
}

class AddTestStationBoxAnodeConditionEvent extends AddSacrificialAnodeEvent {
  final VisualChecksModel anodeConditionValue;
  AddTestStationBoxAnodeConditionEvent({required this.anodeConditionValue});

  @override
  List<Object?> get props => [anodeConditionValue];
}

class  AddSacrificialAnodeAddImageEvent extends  AddSacrificialAnodeEvent {
  final BuildContext context;
  final int mediaType;
   AddSacrificialAnodeAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class  AddSacrificialAnodeSubmitDataEvent extends  AddSacrificialAnodeEvent {
  final BuildContext context;
   AddSacrificialAnodeSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}




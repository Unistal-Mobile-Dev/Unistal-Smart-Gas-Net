part of 'add_ofc_blowing_bloc.dart';

abstract class AddOFCBlowingEvent extends Equatable {
  const AddOFCBlowingEvent();
}

class AddOFCBlowingPageLoadEvent extends AddOFCBlowingEvent {
  final BuildContext context;

  const AddOFCBlowingPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddOFCBlowingSelectDateEvent extends AddOFCBlowingEvent {
  final BuildContext context;

  const AddOFCBlowingSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddOFCBlowingSelectAlignmentEvent extends AddOFCBlowingEvent {
 final AlignmentModel alignmentData;

  const AddOFCBlowingSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddOFCBlowingMultipleSelectAlignmentEvent extends AddOFCBlowingEvent {
  final List<AlignmentModel> alignmentData;

  const AddOFCBlowingMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class CalculateLengthEvent extends AddOFCBlowingEvent {
  final bool isChainageTo;
  final String value;
  final BuildContext context;
  const CalculateLengthEvent({required this.isChainageTo, required this.value, required this.context});
  @override
  List<Object?> get props => [isChainageTo, value, context];
}

class SelectFromJointEvent extends AddOFCBlowingEvent {
  final JointNumberModel fromJointValue;
  const SelectFromJointEvent({required this.fromJointValue});
  @override
  List<Object?> get props => [fromJointValue];
}

class SelectToJointEvent extends AddOFCBlowingEvent {
  final JointNumberModel toJointValue;
  SelectToJointEvent({required this.toJointValue});
  @override
  List<Object?> get props => [toJointValue];
}


class AddOFCBlowingAddImageEvent extends AddOFCBlowingEvent {
  final BuildContext context;
  final int mediaType;

  const AddOFCBlowingAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddOFCBlowingEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}



class AddOFCBlowingSubmitDataEvent extends AddOFCBlowingEvent {
  final BuildContext context;

  const AddOFCBlowingSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

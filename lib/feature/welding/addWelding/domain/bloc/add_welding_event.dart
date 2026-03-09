part of 'add_welding_bloc.dart';

abstract class AddWeldingEvent extends Equatable {
  const AddWeldingEvent();
}

class AddWeldingPageLoadEvent extends AddWeldingEvent {
  final BuildContext context;

  const AddWeldingPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddWeldingSelectDateEvent extends AddWeldingEvent {
  final BuildContext context;

  const AddWeldingSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddWeldingSelectAlignmentEvent extends AddWeldingEvent {
   final AlignmentModel alignmentData;

  const AddWeldingSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddWeldingMultipleSelectAlignmentEvent extends AddWeldingEvent {
  final List<AlignmentModel> alignmentData;

  const AddWeldingMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddWeldingCalculateLengthEvent extends AddWeldingEvent {
  final bool isChainageTo;
  final String value;
  const AddWeldingCalculateLengthEvent({required this.isChainageTo, required this.value});
  @override
  List<Object?> get props => [isChainageTo, value];
}

class AddWeldingSelectWPSEvent extends AddWeldingEvent {
  final WPSModel wpsData;
  final BuildContext context;

  const AddWeldingSelectWPSEvent({required this.wpsData, required this.context});
  @override
  List<Object?> get props => [wpsData, context];
}

class AddWeldingSelectLeftPipeDataEvent extends AddWeldingEvent {
  final PipeModel leftPipeData;

  const AddWeldingSelectLeftPipeDataEvent({required this.leftPipeData});

  @override
  List<Object?> get props => [leftPipeData];
}

class AddWeldingSelectRightPipeDataEvent extends AddWeldingEvent {
  final PipeModel rightPipeData;

  const AddWeldingSelectRightPipeDataEvent({required this.rightPipeData});

  @override
  List<Object?> get props => [rightPipeData];
}

class AddWeldingSelectJointTypeEvent extends AddWeldingEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;

  const AddWeldingSelectJointTypeEvent(
      {required this.jointTypeData, required this.context});

  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddWeldingSelectJointNumberEvent extends AddWeldingEvent {
  final JointNumberModel jointNumberData;

  const AddWeldingSelectJointNumberEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddWeldingSelectFitupDataEvent extends AddWeldingEvent {
  final VisualChecksModel fitupData;

  const AddWeldingSelectFitupDataEvent({required this.fitupData});

  @override
  List<Object?> get props => [fitupData];
}

class AddWeldingSelectWeldVisualEvent extends AddWeldingEvent {
  final VisualChecksModel weldVisualData;

  const AddWeldingSelectWeldVisualEvent({required this.weldVisualData});

  @override
  List<Object?> get props => [weldVisualData];
}

class AddWeldingSelectWelderEvent extends AddWeldingEvent {
  final WelderModel welderData;

  const AddWeldingSelectWelderEvent({
    required this.welderData,
  });

  @override
  List<Object?> get props => [welderData];
}

class AddWeldingAddImageEvent extends AddWeldingEvent {
  final BuildContext context;
  final int mediaType;

  const AddWeldingAddImageEvent(
      {required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class AddWeldingSelectMultiWelderEvent extends AddWeldingEvent {
  final String name;
  final WelderModel welderData;

  const AddWeldingSelectMultiWelderEvent(
      {required this.welderData, required this.name});

  @override
  List<Object?> get props => [welderData, name];
}

class AddWeldingSelectMultiWelderClearEvent extends AddWeldingEvent {
  final String name;

  const AddWeldingSelectMultiWelderClearEvent({required this.name});

  @override
  List<Object?> get props => [ name];
}

class SelectWeatherEvent extends AddWeldingEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class SelectElectrodeDiaE6010Event extends AddWeldingEvent {
  final BuildContext context;
  final ElectrodeDiaData electrodeDiaE6010Value;
  const SelectElectrodeDiaE6010Event({required this.electrodeDiaE6010Value, required this.context});

  @override
  List<Object?> get props => [electrodeDiaE6010Value, context];
}

class SelectElectrodeDiaE6010BatchEvent extends AddWeldingEvent {
  final BuildContext context;
  final ElectrodeBatchData electrodeDiaE6010BatchValue;
  const SelectElectrodeDiaE6010BatchEvent({
    required this.electrodeDiaE6010BatchValue,
    required this.context,
  });

  @override
  List<Object?> get props => [electrodeDiaE6010BatchValue, context];
}

class SelectElectrodeEiaE8010p1Event extends AddWeldingEvent {
  final BuildContext context;
  final ElectrodeDiaData electrodeEiaE8010p1Value;
  const SelectElectrodeEiaE8010p1Event({required this.electrodeEiaE8010p1Value, required this.context});

  @override
  List<Object?> get props => [electrodeEiaE8010p1Value, context];
}

class SelectElectrodeEiaE8010p1BatchEvent extends AddWeldingEvent {
  final BuildContext context;
  final ElectrodeBatchData electrodeEiaE8010p1BatchValue;
  const SelectElectrodeEiaE8010p1BatchEvent({required this.electrodeEiaE8010p1BatchValue, required this.context});

  @override
  List<Object?> get props => [electrodeEiaE8010p1BatchValue, context];
}

class SelectElectrodeDiaE9045Event extends AddWeldingEvent {
  final BuildContext context;
  final ElectrodeDiaData electrodeDiaE9045Value;
  const SelectElectrodeDiaE9045Event({required this.electrodeDiaE9045Value, required this.context});

  @override
  List<Object?> get props => [electrodeDiaE9045Value, context];
}

class SelectElectrodeDiaE9045BatchEvent extends AddWeldingEvent {
  final BuildContext context;
  final ElectrodeBatchData electrodeDiaE9045BatchValue;
  const SelectElectrodeDiaE9045BatchEvent({
    required this.electrodeDiaE9045BatchValue,
    required this.context,
  });

  @override
  List<Object?> get props => [electrodeDiaE9045BatchValue, context];
}


class AddWeldingSearchPipeDataEvent extends AddWeldingEvent {
  final String keyword;
  final BuildContext context;
  final bool isLeftPipe;
  final bool isRightPipe;

  const AddWeldingSearchPipeDataEvent(
      {required this.keyword,
      required this.context,
      required this.isLeftPipe,
      required this.isRightPipe});

  @override
  List<Object?> get props => [keyword, context, isLeftPipe, isRightPipe];
}

class AddWeldingSubmitDataEvent extends AddWeldingEvent {
  final BuildContext context;

  const AddWeldingSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

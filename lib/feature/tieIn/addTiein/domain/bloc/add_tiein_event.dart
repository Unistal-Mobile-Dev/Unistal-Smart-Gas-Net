part of 'add_tiein_bloc.dart';

abstract class AddTieinEvent extends Equatable {
  const AddTieinEvent();
}

class AddTieinPageLoadEvent extends AddTieinEvent {
  final BuildContext context;

  const AddTieinPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddTieinSelectDateEvent extends AddTieinEvent {
  final BuildContext context;

  const AddTieinSelectDateEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddTieinSelectAlignmentEvent extends AddTieinEvent {
   final AlignmentModel alignmentData;

  const AddTieinSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddTieinMultipleSelectAlignmentEvent extends AddTieinEvent {
  final List<AlignmentModel> alignmentData;

  const AddTieinMultipleSelectAlignmentEvent({required this.alignmentData});

  @override
  List<Object?> get props => [alignmentData];
}

class AddTieinSelectWPSEvent extends AddTieinEvent {
  final WPSModel wpsData;
  final BuildContext context;

  const AddTieinSelectWPSEvent({required this.wpsData, required this.context});

  @override
  List<Object?> get props => [wpsData, context];
}

class AddTieinSelectLeftPipeDataEvent extends AddTieinEvent {
  final PipeModel leftPipeData;

  const AddTieinSelectLeftPipeDataEvent({required this.leftPipeData});

  @override
  List<Object?> get props => [leftPipeData];
}

class AddTieinSelectRightPipeDataEvent extends AddTieinEvent {
  final PipeModel rightPipeData;

  const AddTieinSelectRightPipeDataEvent({required this.rightPipeData});

  @override
  List<Object?> get props => [rightPipeData];
}

class AddTieinSelectJointTypeEvent extends AddTieinEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;

  const AddTieinSelectJointTypeEvent(
      {required this.jointTypeData, required this.context});

  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddTieinSelectJointNumberEvent extends AddTieinEvent {
  final JointNumberModel jointNumberData;

  const AddTieinSelectJointNumberEvent({required this.jointNumberData});

  @override
  List<Object?> get props => [jointNumberData];
}

class AddTieinSelectFitupDataEvent extends AddTieinEvent {
  final VisualChecksModel fitupData;

  const AddTieinSelectFitupDataEvent({required this.fitupData});

  @override
  List<Object?> get props => [fitupData];
}

class AddTieinSelectWeldVisualEvent extends AddTieinEvent {
  final VisualChecksModel weldVisualData;

  const AddTieinSelectWeldVisualEvent({required this.weldVisualData});

  @override
  List<Object?> get props => [weldVisualData];
}

class AddTieinSelectWelderEvent extends AddTieinEvent {
  final WelderModel welderData;

  const AddTieinSelectWelderEvent({
    required this.welderData,
  });

  @override
  List<Object?> get props => [welderData];
}

class AddTieinAddImageEvent extends AddTieinEvent {
  final BuildContext context;
  final int mediaType;

  const AddTieinAddImageEvent({required this.context, required this.mediaType});

  @override
  List<Object?> get props => [context, mediaType];
}

class AddTieinSelectMultiWelderEvent extends AddTieinEvent {
  final String name;
  final WelderModel welderData;

  const AddTieinSelectMultiWelderEvent(
      {required this.welderData, required this.name});

  @override
  List<Object?> get props => [welderData, name];
}

class SelectWeatherEvent extends AddTieinEvent {
  final WeatherModel weatherData;

  const SelectWeatherEvent({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class AddTieinSearchPipeDataEvent extends AddTieinEvent {
  final String keyword;
  final BuildContext context;
  final bool isLeftPipe;
  final bool isRightPipe;

  const AddTieinSearchPipeDataEvent(
      {required this.keyword,
      required this.context,
      required this.isLeftPipe,
      required this.isRightPipe});

  @override
  List<Object?> get props => [keyword, context, isLeftPipe, isRightPipe];
}

class AddTieinSubmitDataEvent extends AddTieinEvent {
  final BuildContext context;

  const AddTieinSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
class SelectElectrodeDiaE6010Event extends AddTieinEvent {
  final BuildContext context;
  final ElectrodeDiaData electrodeDiaE6010Value;
  const SelectElectrodeDiaE6010Event({required this.electrodeDiaE6010Value, required this.context});

  @override
  List<Object?> get props => [electrodeDiaE6010Value, context];
}

class SelectElectrodeDiaE6010BatchEvent extends AddTieinEvent {
  final BuildContext context;
  final ElectrodeBatchData electrodeDiaE6010BatchValue;
  const SelectElectrodeDiaE6010BatchEvent({
    required this.electrodeDiaE6010BatchValue,
    required this.context,
  });

  @override
  List<Object?> get props => [electrodeDiaE6010BatchValue, context];
}

class SelectElectrodeEiaE7010p1Event extends AddTieinEvent {
  final BuildContext context;
  final ElectrodeDiaData electrodeEiaE8010p1Value;
  const SelectElectrodeEiaE7010p1Event({required this.electrodeEiaE8010p1Value, required this.context});

  @override
  List<Object?> get props => [electrodeEiaE8010p1Value, context];
}


class SelectElectrodeEiaE7010p1BatchEvent extends AddTieinEvent {
  final BuildContext context;
  final ElectrodeBatchData electrodeEiaE8010p1BatchValue;
  const SelectElectrodeEiaE7010p1BatchEvent({required this.electrodeEiaE8010p1BatchValue, required this.context});

  @override
  List<Object?> get props => [electrodeEiaE8010p1BatchValue, context];
}

class SelectElectrodeDiaE9045p2Event extends AddTieinEvent {
  final BuildContext context;
  final ElectrodeDiaData electrodeDiaE9045p2Value;
  const SelectElectrodeDiaE9045p2Event({required this.electrodeDiaE9045p2Value, required this.context});

  @override
  List<Object?> get props => [electrodeDiaE9045p2Value, context];
}


class SelectElectrodeDiaE9045p2BatchEvent extends AddTieinEvent {
  final BuildContext context;
  final ElectrodeBatchData electrodeDiaE9045p2BatchValue;
  const SelectElectrodeDiaE9045p2BatchEvent({required this.electrodeDiaE9045p2BatchValue, required this.context});

  @override
  List<Object?> get props => [electrodeDiaE9045p2BatchValue, context];
}

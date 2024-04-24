part of 'add_obstruction_point_bloc.dart';

abstract class AddObstructionPointEvent extends Equatable {
  const AddObstructionPointEvent();
}

class AddObstructionPointPageLoadEvent extends AddObstructionPointEvent {
  final BuildContext context;
  const AddObstructionPointPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddObstructionPointSelectDateEvent extends AddObstructionPointEvent {
  final BuildContext context;
  const AddObstructionPointSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddObstructionPointSelectSpreadEvent extends AddObstructionPointEvent {
  final SpreadTypeModel  spreadTypeData;
  const AddObstructionPointSelectSpreadEvent({required this.spreadTypeData});
  @override
  List<Object?> get props => [spreadTypeData];
}

class AddObstructionPointSelectSectionEvent extends AddObstructionPointEvent {
  final SectionTypeModel  sectionTypeData;
  const AddObstructionPointSelectSectionEvent({required this.sectionTypeData});
  @override
  List<Object?> get props => [sectionTypeData];
}


class AddObstructionPointAddImageEvent extends AddObstructionPointEvent {
  final BuildContext context;
  final int mediaType;
  const AddObstructionPointAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddObstructionPointEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddObstructionPointCaptureNorthingLocationEvent extends AddObstructionPointEvent{
  final BuildContext context;
  const AddObstructionPointCaptureNorthingLocationEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddObstructionPointCaptureEastingLocationEvent extends AddObstructionPointEvent{
  final BuildContext context;
  const AddObstructionPointCaptureEastingLocationEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddObstructionPointSubmitDataEvent extends AddObstructionPointEvent {
  final BuildContext context;
  const AddObstructionPointSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
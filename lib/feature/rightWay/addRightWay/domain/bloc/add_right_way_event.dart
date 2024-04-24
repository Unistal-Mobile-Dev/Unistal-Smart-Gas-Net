part of 'add_right_way_bloc.dart';

abstract class AddRightWayEvent extends Equatable {
  const AddRightWayEvent();
}

class AddRightWayPageLoadEvent extends AddRightWayEvent {
  final BuildContext context;
  const AddRightWayPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRightWaySelectDateEvent extends AddRightWayEvent {
  final BuildContext context;
  const AddRightWaySelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRightWaySelectSpreadEvent extends AddRightWayEvent {
  final SpreadTypeModel  spreadTypeData;
  const AddRightWaySelectSpreadEvent({required this.spreadTypeData});
  @override
  List<Object?> get props => [spreadTypeData];
}

class AddRightWaySelectSectionEvent extends AddRightWayEvent {
  final SectionTypeModel  sectionTypeData;
  const AddRightWaySelectSectionEvent({required this.sectionTypeData});
  @override
  List<Object?> get props => [sectionTypeData];
}


class AddRightWayAddImageEvent extends AddRightWayEvent {
  final BuildContext context;
  final int mediaType;
  const AddRightWayAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddRightWayEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddRightWayCaptureNorthingLocationEvent extends AddRightWayEvent{
  final BuildContext context;
  const AddRightWayCaptureNorthingLocationEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRightWayCaptureEastingLocationEvent extends AddRightWayEvent{
  final BuildContext context;
  const AddRightWayCaptureEastingLocationEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRightWaySelectRodeSideEvent extends AddRightWayEvent{
  final String rodeSideValue;
  const AddRightWaySelectRodeSideEvent({required this.rodeSideValue});
  @override
  List<Object?> get props => [rodeSideValue];
}

class AddRightWaySubmitDataEvent extends AddRightWayEvent {
  final BuildContext context;
  const AddRightWaySubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
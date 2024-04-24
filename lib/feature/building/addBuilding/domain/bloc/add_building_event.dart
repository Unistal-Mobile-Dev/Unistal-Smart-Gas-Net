part of 'add_building_bloc.dart';

abstract class AddBuildingEvent extends Equatable {
  const AddBuildingEvent();
}

class AddBuildingPageLoadEvent extends AddBuildingEvent {
  final BuildContext context;
  const AddBuildingPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddBuildingSelectDateEvent extends AddBuildingEvent {
  final BuildContext context;
  const AddBuildingSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddBuildingSelectAlignmentEvent extends AddBuildingEvent {
  final AlignmentModel  alignmentData;
  const AddBuildingSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddBuildingSelectSpreadEvent extends AddBuildingEvent {
  final SpreadTypeModel  spreadTypeData;
  const AddBuildingSelectSpreadEvent({required this.spreadTypeData});
  @override
  List<Object?> get props => [spreadTypeData];
}

class AddBuildingSelectSectionEvent extends AddBuildingEvent {
  final SectionTypeModel  sectionTypeData;
  const AddBuildingSelectSectionEvent({required this.sectionTypeData});
  @override
  List<Object?> get props => [sectionTypeData];
}

class AddBuildingSelectBuildingCategoryEvent extends AddBuildingEvent {
  final BuildingCategoryTypeModel  buildingCategoryTypeData;
  const AddBuildingSelectBuildingCategoryEvent({required this.buildingCategoryTypeData});
  @override
  List<Object?> get props => [buildingCategoryTypeData];
}

class AddBuildingAddImageEvent extends AddBuildingEvent {
  final BuildContext context;
  final int mediaType;
  const AddBuildingAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context, mediaType];
}

class SelectWeatherEvent extends AddBuildingEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddBuildingCaptureNorthingLocationEvent extends AddBuildingEvent{
  final BuildContext context;
  const AddBuildingCaptureNorthingLocationEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddBuildingCaptureEastingLocationEvent extends AddBuildingEvent{
  final BuildContext context;
  const AddBuildingCaptureEastingLocationEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddBuildingSubmitDataEvent extends AddBuildingEvent {
  final BuildContext context;
  const AddBuildingSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
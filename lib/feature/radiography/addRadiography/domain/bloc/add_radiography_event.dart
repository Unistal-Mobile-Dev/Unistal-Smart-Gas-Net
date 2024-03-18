part of 'add_radiography_bloc.dart';

abstract class AddRadiographyEvent extends Equatable {
  const AddRadiographyEvent();
}

class AddRadiographyPageLoadEvent extends AddRadiographyEvent {
  final BuildContext context;
  const AddRadiographyPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRadiographySelectDateEvent extends AddRadiographyEvent {
  final BuildContext context;
  const AddRadiographySelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddRadiographySelectAlignmentEvent extends AddRadiographyEvent {
  final AlignmentModel  alignmentData;
  const AddRadiographySelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddRadiographySelectJointTypeDataEvent extends AddRadiographyEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddRadiographySelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddRadiographySelectJointNumberDataEvent extends AddRadiographyEvent {
  final JointNumberModel jointNumberData;
  const AddRadiographySelectJointNumberDataEvent({required this.jointNumberData,});
  @override
  List<Object?> get props => [jointNumberData,];
}


class AddRadiographySelectSegmentDataEvent extends AddRadiographyEvent {
  final int index;
  final int segmentIndex;
  const AddRadiographySelectSegmentDataEvent({required this.index, required this.segmentIndex});
  @override
  List<Object?> get props => [index, segmentIndex];
}

class AddRadiographySelectToJointDataEvent extends AddRadiographyEvent {
  final JointNumberModel jointNumberData;
  const AddRadiographySelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddRadiographyAddImageEvent extends AddRadiographyEvent {
  final BuildContext context;
  final int mediaType;
  const AddRadiographyAddImageEvent({required this.context, required this.mediaType});
  @override
  List<Object?> get props => [context,mediaType];
}

class AddRadiographySelectWelderDataEvent extends AddRadiographyEvent {
  final int index;
  final int welderIndex;
  final WelderModel welderData;
  const AddRadiographySelectWelderDataEvent({required this.index, required this.welderData, required this.welderIndex});
  @override
  List<Object?> get props => [AddRadiographySelectWelderDataEvent,welderData, welderIndex];
}
class AddRadiographySelectHotPassWelderEvent extends AddRadiographyEvent {
  final int index;
  final WelderModel welderData;
  const AddRadiographySelectHotPassWelderEvent({required this.index, required this.welderData});
  @override
  List<Object?> get props => [AddRadiographySelectWelderDataEvent,welderData];
}
class AddRadiographySelectFillerWelderEvent extends AddRadiographyEvent {
  final int index;
  final WelderModel welderData;
  const AddRadiographySelectFillerWelderEvent({required this.index, required this.welderData});
  @override
  List<Object?> get props => [AddRadiographySelectWelderDataEvent,welderData];
}

class AddRadiographySelectNdtAgencyDataEvent extends AddRadiographyEvent {
  final NdtStatusModel ndtAgencyData;
  const AddRadiographySelectNdtAgencyDataEvent({required this.ndtAgencyData});
  @override
  List<Object?> get props => [ndtAgencyData];
}

class AddRadiographySelectDspplDataEvent extends AddRadiographyEvent {
  final NdtStatusModel dspplData;
  const AddRadiographySelectDspplDataEvent({required this.dspplData});
  @override
  List<Object?> get props => [dspplData];
}


class AddRadiographySelectMeconPbgplDataEvent extends AddRadiographyEvent {
  final NdtStatusModel meconPbgplData;
  const AddRadiographySelectMeconPbgplDataEvent({required this.meconPbgplData});
  @override
  List<Object?> get props => [meconPbgplData];
}

class AddRadiographySelectNdtSourceDataEvent extends AddRadiographyEvent {
  final NdtSourceModel ndtSourceData;
  const AddRadiographySelectNdtSourceDataEvent({required this.ndtSourceData});
  @override
  List<Object?> get props => [ndtSourceData];
}

class AddRadiographySelectCappingWelderEvent extends AddRadiographyEvent {
  final int index;
  final WelderModel welderData;
  const AddRadiographySelectCappingWelderEvent({required this.index, required this.welderData});
  @override
  List<Object?> get props => [AddRadiographySelectWelderDataEvent,welderData];
}




class SelectWeatherEvent extends AddRadiographyEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddRadiographySubmitDataEvent extends AddRadiographyEvent {
  final BuildContext context;
  const AddRadiographySubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
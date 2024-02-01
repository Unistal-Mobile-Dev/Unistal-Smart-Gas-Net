part of 'add_ndt_mut_bloc.dart';

abstract class AddNdtMutEvent extends Equatable {
  const AddNdtMutEvent();
}
class AddNdtMutPageLoadEvent extends AddNdtMutEvent {
  final BuildContext context;
  const AddNdtMutPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddNdtMutSelectDateEvent extends AddNdtMutEvent {
  final BuildContext context;
  const AddNdtMutSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddNdtMutSelectAlignmentEvent extends AddNdtMutEvent {
  final AlignmentModel  alignmentData;
  const AddNdtMutSelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddNdtMutSelectJointTypeDataEvent extends AddNdtMutEvent {
  final JointTypeModel jointTypeData;
  final BuildContext context;
  const AddNdtMutSelectJointTypeDataEvent({required this.jointTypeData, required this.context});
  @override
  List<Object?> get props => [jointTypeData, context];
}

class AddNdtMutSelectJointNumberDataEvent extends AddNdtMutEvent {
  final JointNumberModel jointNumberData;
  const AddNdtMutSelectJointNumberDataEvent({required this.jointNumberData,});
  @override
  List<Object?> get props => [jointNumberData,];
}

class AddNdtMutSelectSegmentDataEvent extends AddNdtMutEvent {
  final int index;
  final int segmentIndex;
  const AddNdtMutSelectSegmentDataEvent({required this.index, required this.segmentIndex});
  @override
  List<Object?> get props => [index, segmentIndex];
}

class AddNdtMutSelectToJointDataEvent extends AddNdtMutEvent {
  final JointNumberModel jointNumberData;
  const AddNdtMutSelectToJointDataEvent({required this.jointNumberData});
  @override
  List<Object?> get props => [jointNumberData];
}

class AddNdtMutAddImageEvent extends AddNdtMutEvent {
  final BuildContext context;
  const AddNdtMutAddImageEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class SelectWeatherEvent extends AddNdtMutEvent{
  final WeatherModel weatherData;
  const SelectWeatherEvent({required this.weatherData});
  @override
  List<Object?> get props => [weatherData];
}


class AddNdtMutSubmitDataEvent extends AddNdtMutEvent {
  final BuildContext context;
  const AddNdtMutSubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
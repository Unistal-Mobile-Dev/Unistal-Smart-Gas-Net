part of 'add_soil_resistivity_bloc.dart';

abstract class AddSoilResistivityEvent extends Equatable {
  const AddSoilResistivityEvent();
}

class AddSoilResistivityPageLoadEvent extends AddSoilResistivityEvent {
  final BuildContext context;
  const AddSoilResistivityPageLoadEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddSoilResistivitySelectDateEvent extends AddSoilResistivityEvent {
  final BuildContext context;
  const AddSoilResistivitySelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddSoilResistivitySelectAlignmentEvent extends AddSoilResistivityEvent {
  final AlignmentModel  alignmentData;
  const AddSoilResistivitySelectAlignmentEvent({required this.alignmentData});
  @override
  List<Object?> get props => [alignmentData];
}

class AddSoilResistivityAddImageEvent extends AddSoilResistivityEvent {
  final BuildContext context;
  const AddSoilResistivityAddImageEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddSoilResistivitySubmitDataEvent extends AddSoilResistivityEvent {
  final BuildContext context;
  const AddSoilResistivitySubmitDataEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
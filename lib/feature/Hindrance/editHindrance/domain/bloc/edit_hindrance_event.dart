import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class EditHindranceEvent extends Equatable {
  const EditHindranceEvent();
}

class EditHindrancePageLoadEvent extends EditHindranceEvent {
  final BuildContext context;

  const EditHindrancePageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}


class EditHindranceResolutionCloseDateEvent extends EditHindranceEvent {
  final BuildContext context;
  const EditHindranceResolutionCloseDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class SelectCameraCaptureEvent extends EditHindranceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class SelectGalleryCaptureEvent extends EditHindranceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EditHindranceSubmitDataEvent extends EditHindranceEvent {
  final BuildContext context;

  const EditHindranceSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}



import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/domain/model/hindrance_category_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';

abstract class AddHindranceEvent extends Equatable {
  const AddHindranceEvent();
}

class AddHindrancePageLoadEvent extends AddHindranceEvent {
  final BuildContext context;

  const AddHindrancePageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class AddHindranceSelectDateEvent extends AddHindranceEvent {
  final BuildContext context;
  const AddHindranceSelectDateEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class AddHindranceSelectCategoryEvent extends AddHindranceEvent {
  final HindranceCategoryData hindranceCategory;
  const AddHindranceSelectCategoryEvent({required this.hindranceCategory});
  @override
  List<Object?> get props => [hindranceCategory];
}

class AddHindranceSelectTypeEvent extends AddHindranceEvent {
  final HindranceCategoryData hindranceType;
  const AddHindranceSelectTypeEvent({required this.hindranceType});
  @override
  List<Object?> get props => [hindranceType];
}

class AddHindranceActivityAffectedEvent extends AddHindranceEvent {
  final ActivitySectionData activityAffected;
  const AddHindranceActivityAffectedEvent({required this.activityAffected});
  @override
  List<Object?> get props => [activityAffected];
}
class AddHindranceResponsibleByEvent extends AddHindranceEvent {
  final HindranceCategoryData responsibleBy;
  const AddHindranceResponsibleByEvent({required this.responsibleBy});
  @override
  List<Object?> get props => [responsibleBy];
}

class CalculateLengthEvent extends AddHindranceEvent {
  final bool isChainageTo;
  final String value;
  final BuildContext context;
  const CalculateLengthEvent({required this.isChainageTo, required this.value, required this.context});
  @override
  List<Object?> get props => [isChainageTo, value, context];
}



class SelectCameraCaptureEvent extends AddHindranceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class SelectGalleryCaptureEvent extends AddHindranceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddHindranceSubmitDataEvent extends AddHindranceEvent {
  final BuildContext context;

  const AddHindranceSubmitDataEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

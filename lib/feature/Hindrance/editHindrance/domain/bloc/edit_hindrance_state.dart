

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/EditHindrance/domain/model/hindrance_category_model.dart';

abstract class EditHindranceState extends Equatable {
  const EditHindranceState();
}

class EditHindranceInitial extends EditHindranceState {
  @override
  List<Object> get props => [];
}

class EditHindrancePageLoadState extends EditHindranceInitial {
  @override
  List<Object> get props => [];
}

class FetchEditHindranceDataState extends EditHindranceInitial {
  final bool isLoader;
  final File file;
  final TextEditingController dateCtrl;
  final TextEditingController hindranceCategoryCtrl;
  final TextEditingController hindranceTypeCtrl;
  final TextEditingController activityAffectedCtrl;
  final TextEditingController responsibleByCtrl;
  final TextEditingController reportNumberCtrl;
  final TextEditingController locationCtrl;
  final TextEditingController chainageFromCtrl;
  final TextEditingController chainageToCtrl;
  final TextEditingController lengthCtrl;
  final TextEditingController resolutionDateCtrl;
  final TextEditingController resolutionNotesCtrl;
  final TextEditingController resolutionEditNotesCtrl;


  FetchEditHindranceDataState({
    required this.isLoader,
    required this.file,
    required this.dateCtrl,
    required this.hindranceCategoryCtrl,
    required this.hindranceTypeCtrl,
    required this.activityAffectedCtrl,
    required this.responsibleByCtrl,
    required this.reportNumberCtrl,
    required this.locationCtrl,
    required this.chainageFromCtrl,
    required this.chainageToCtrl,
    required this.lengthCtrl,
    required this.resolutionDateCtrl,
    required this.resolutionNotesCtrl,
    required this.resolutionEditNotesCtrl,

      });

  @override
  List<Object> get props => [
    isLoader,
    file,
    dateCtrl,
    hindranceCategoryCtrl,
    hindranceTypeCtrl,
    activityAffectedCtrl,
    responsibleByCtrl,
    reportNumberCtrl,
    locationCtrl,
    chainageFromCtrl,
    chainageToCtrl,
    lengthCtrl,
    resolutionDateCtrl,
    resolutionNotesCtrl,
    resolutionEditNotesCtrl,

      ];
}

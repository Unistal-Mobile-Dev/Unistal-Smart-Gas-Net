

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/domain/model/hindrance_category_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';

abstract class AddHindranceState extends Equatable {
  const AddHindranceState();
}

class AddHindranceInitial extends AddHindranceState {
  @override
  List<Object> get props => [];
}

class AddHindrancePageLoadState extends AddHindranceInitial {
  @override
  List<Object> get props => [];
}

class FetchAddHindranceDataState extends AddHindranceInitial {
  final bool isLoader;
  final bool isHindranceLoader;
  final File file;
  final TextEditingController dateCtrl;
  final TextEditingController reportNumberCtrl;
  final TextEditingController locationCtrl;
  final TextEditingController chainageFromCtrl;
  final TextEditingController chainageToCtrl;
  final TextEditingController lengthCtrl;
  final TextEditingController resolutionNotesCtrl;
  final TextEditingController activityRemarkCtrl;
  final HindranceCategoryData hindranceCategoryVal;
  final List<HindranceCategoryData> listOfHindranceCategory;
  final HindranceCategoryData hindranceTypeVal;
  final List<HindranceCategoryData> listOfHindranceType;
  final ActivitySectionData activityAffectedVal;
  final List<ActivitySectionData> listOfActivityAffected;
  final HindranceCategoryData responsibleByVal;
  final List<HindranceCategoryData> listOfResponsibleBy;

  FetchAddHindranceDataState({
    required this.isLoader,
    required this.isHindranceLoader,
    required this.file,
    required this.dateCtrl,
    required this.reportNumberCtrl,
    required this.locationCtrl,
    required this.chainageFromCtrl,
    required this.chainageToCtrl,
    required this.lengthCtrl,
    required this.resolutionNotesCtrl,
    required this.activityRemarkCtrl,
    required this.hindranceCategoryVal,
    required this.listOfHindranceCategory,
    required this.hindranceTypeVal,
    required this.listOfHindranceType,
    required this.activityAffectedVal,
    required this.listOfActivityAffected,
    required this.responsibleByVal,
    required this.listOfResponsibleBy,
      });

  @override
  List<Object> get props => [
    isLoader,
    isHindranceLoader,
    file,
    dateCtrl,
    reportNumberCtrl,
    locationCtrl,
    chainageFromCtrl,
    chainageToCtrl,
    lengthCtrl,
    resolutionNotesCtrl,
    activityRemarkCtrl,
    hindranceCategoryVal,
    listOfHindranceCategory,
    hindranceTypeVal,
    listOfHindranceType,
    activityAffectedVal,
    listOfActivityAffected,
    responsibleByVal,
    listOfResponsibleBy,
      ];
}

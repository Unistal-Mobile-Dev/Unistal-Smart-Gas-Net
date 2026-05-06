import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/domain/model/hindrance_category_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/addHindrance/helper/add_hindrance_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/helper/home_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

import 'add_hindrance_event.dart';
import 'add_hindrance_state.dart';

class AddHindranceBloc extends Bloc<AddHindranceEvent, AddHindranceState> {
  bool isLoader = false;
  bool isHindranceLoader = false;
  File file = File("");

  TextEditingController dateCtrl = TextEditingController();
  TextEditingController reportNumberCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController chainageFromCtrl = TextEditingController();
  TextEditingController chainageToCtrl = TextEditingController();
  TextEditingController lengthCtrl = TextEditingController();
  TextEditingController resolutionNotesCtrl = TextEditingController();
  TextEditingController activityRemarkCtrl = TextEditingController();

  LoginDataModel _userData = LoginDataModel();

  LoginDataModel get userData => _userData;

  HindranceCategoryData hindranceCategoryVal = HindranceCategoryData();
  List<HindranceCategoryData> listOfHindranceCategory = [];

  HindranceCategoryData hindranceTypeVal = HindranceCategoryData();
  List<HindranceCategoryData> listOfHindranceType = [];

  ActivitySectionData activityAffectedVal = ActivitySectionData();
  List<ActivitySectionData> listOfActivityAffected = [];

  HindranceCategoryData responsibleByVal = HindranceCategoryData();
  List<HindranceCategoryData> listOfResponsibleBy = [];

  AddHindranceBloc() : super(AddHindranceInitial()) {
    on<AddHindrancePageLoadEvent>(_pageLoad);
    on<AddHindranceSelectCategoryEvent>(_selectHindranceCategory);
    on<AddHindranceSelectTypeEvent>(_selectHindranceType);
    on<AddHindranceActivityAffectedEvent>(_selectActivityAffected);
    on<AddHindranceResponsibleByEvent>(_selectResponsibleBy);
    on<CalculateLengthEvent>(_calculateChainage);
    on<AddHindranceSelectDateEvent>(_selectDate);
    on<SelectCameraCaptureEvent>(_selectCameraCapture);
    on<SelectGalleryCaptureEvent>(_selectGalleryCapture);
    on<AddHindranceSubmitDataEvent>(_submitData);
  }

  _pageLoad(AddHindrancePageLoadEvent event, emit) async {
    emit(AddHindrancePageLoadState());
    isLoader = false;
    isHindranceLoader = false;
    file = File("");
    dateCtrl = TextEditingController();
    reportNumberCtrl = TextEditingController();
    locationCtrl = TextEditingController();
    chainageFromCtrl = TextEditingController();
    chainageToCtrl = TextEditingController();
    lengthCtrl = TextEditingController();
    resolutionNotesCtrl = TextEditingController();
    activityRemarkCtrl = TextEditingController();
    hindranceCategoryVal = HindranceCategoryData();
    hindranceTypeVal = HindranceCategoryData();
    activityAffectedVal = ActivitySectionData();
    responsibleByVal = HindranceCategoryData();
    listOfHindranceCategory = [];
    listOfHindranceType = [];
    listOfActivityAffected = [];
    listOfResponsibleBy = [];

    _userData = UserInfo.instanceInit()!.userData!;
    var res = await AddHindranceHelper.fetchHindranceNextId(userData: userData);
    if(res != null){
      reportNumberCtrl.text = res.toString();
    }
    listOfHindranceCategory = await AddHindranceHelper.fetchHindranceCategoryData();
    listOfActivityAffected = (await HomeHelper.activityBySectionApi(userData: userData)) ?? [];
    listOfResponsibleBy = await AddHindranceHelper.fetchResponsibleByData();
    _eventComplete(emit);
  }

  _selectHindranceCategory(AddHindranceSelectCategoryEvent event, emit) async {
    hindranceTypeVal = HindranceCategoryData();
    listOfHindranceType = [];
    hindranceCategoryVal = event.hindranceCategory;
    if (hindranceCategoryVal.id != null) {
      isHindranceLoader = true;
      _eventComplete(emit);
      listOfHindranceType = await AddHindranceHelper.fetchHindranceTypeData(
          categoryId: hindranceCategoryVal.id.toString());
      isHindranceLoader = false;
      _eventComplete(emit);
    }
    _eventComplete(emit);
  }

  _selectHindranceType(AddHindranceSelectTypeEvent event, emit) {
    hindranceTypeVal = event.hindranceType;
    _eventComplete(emit);
  }

  _selectActivityAffected(AddHindranceActivityAffectedEvent event, emit) {
    activityAffectedVal = event.activityAffected;
    _eventComplete(emit);
  }

  _selectResponsibleBy(AddHindranceResponsibleByEvent event, emit) {
    responsibleByVal = event.responsibleBy;
    _eventComplete(emit);
  }

  _calculateChainage(CalculateLengthEvent event, emit) {
    bool isChainageTo = event.isChainageTo;
    String value = event.value;
    if (value.isEmpty) {
      lengthCtrl.text = "";
    } else if (isChainageTo == true &&
        value.isNotEmpty &&
        chainageFromCtrl.text.toString().isNotEmpty) {
      double chainageTo = double.parse(value.toString());
      double chainageFrom = double.parse(chainageFromCtrl.text.toString());
      if (chainageTo < chainageFrom) {
        lengthCtrl.text = "";
        SnackBarErrorWidget(event.context).show(
            message:
                "Chainage TO must be greater than or equal to Chainage FROM");
      } else {
        lengthCtrl.text = "${chainageTo - chainageFrom}";
      }
    } else if (isChainageTo == false &&
        value.isNotEmpty &&
        chainageToCtrl.text.toString().isNotEmpty) {
      double chainageTo = double.parse(chainageToCtrl.text.toString());
      double chainageFrom = double.parse(value);
      if (chainageTo < chainageFrom) {
        lengthCtrl.text = "";
        SnackBarErrorWidget(event.context).show(
            message:
                "Chainage TO must be greater than or equal to Chainage FROM");
      } else {
        lengthCtrl.text = "${chainageTo - chainageFrom}";
      }
    }
    _eventComplete(emit);
  }

  _selectDate(AddHindranceSelectDateEvent event, emit) async {
    DateTime? pickedDate = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDateChange = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateCtrl.text = formattedDateChange.toString();
      _eventComplete(emit);
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }



  _selectCameraCapture(SelectCameraCaptureEvent event, emit) async {
    var photoPath = await DashboardHelper.cameraCapture();
    log("photo-->${photoPath}");
    if (photoPath != null) {
      file = photoPath;
    }
    _eventComplete(emit);
  }

  _selectGalleryCapture(SelectGalleryCaptureEvent event, emit) async {
    var photoPath = await DashboardHelper.galleryCapture();
    log("photo-->${photoPath}");
    if (photoPath != null) {
      file = photoPath;
    }
    _eventComplete(emit);
  }

  _submitData(AddHindranceSubmitDataEvent event, emit) async {
    var textFiledValidation = await AddHindranceHelper.textFiledValidation(
      context: event.context,
      date: dateCtrl.text.toString(),
      reportNo: reportNumberCtrl.text.toString(),
      resolutionNotes: activityRemarkCtrl.text.toString(),
      chainageFrom: chainageFromCtrl.text.toString(),
      chainageTo: chainageToCtrl.text.toString(),
      activityAffected: activityAffectedVal,
      hindranceCategory: hindranceCategoryVal,
      hindranceType: hindranceTypeVal,
      responsibleBy: responsibleByVal,

    );
    if (textFiledValidation == false) {
      return;
    }
    isLoader = true;
    _eventComplete(emit);
    var res = await AddHindranceHelper.submitData(
      context: event.context,
      userData: userData,
      date: dateCtrl.text.toString(),
      reportNo: reportNumberCtrl.text.toString(),
      resolutionNotes: activityRemarkCtrl.text.toString(),
      chainageFrom: chainageFromCtrl.text.toString(),
      locationAdd: locationCtrl.text.toString(),
      chainageTo: chainageToCtrl.text.toString(),
      file: file,
      activityAffected: activityAffectedVal,
      hindranceCategory: hindranceCategoryVal,
      hindranceType: hindranceTypeVal,
      responsibleBy: responsibleByVal,
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      file = File("");
      dateCtrl = TextEditingController();
      reportNumberCtrl = TextEditingController();
      locationCtrl = TextEditingController();
      chainageFromCtrl = TextEditingController();
      chainageToCtrl = TextEditingController();
      lengthCtrl = TextEditingController();
      resolutionNotesCtrl = TextEditingController();
      activityRemarkCtrl = TextEditingController();
      hindranceCategoryVal = HindranceCategoryData();
      hindranceTypeVal = HindranceCategoryData();
      activityAffectedVal = ActivitySectionData();
      responsibleByVal = HindranceCategoryData();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<AddHindranceState> emit) {
    emit(FetchAddHindranceDataState(
      isLoader: isLoader,
      isHindranceLoader: isHindranceLoader,
      file: file,
      dateCtrl: dateCtrl,
      reportNumberCtrl: reportNumberCtrl,
      locationCtrl: locationCtrl,
      chainageFromCtrl: chainageFromCtrl,
      chainageToCtrl: chainageToCtrl,
      lengthCtrl: lengthCtrl,
      resolutionNotesCtrl: resolutionNotesCtrl,
      activityRemarkCtrl: activityRemarkCtrl,
      hindranceCategoryVal: hindranceCategoryVal,
      listOfHindranceCategory: listOfHindranceCategory,
      hindranceTypeVal: hindranceTypeVal,
      listOfHindranceType: listOfHindranceType,
      activityAffectedVal: activityAffectedVal,
      listOfActivityAffected: listOfActivityAffected,
      responsibleByVal: responsibleByVal,
      listOfResponsibleBy: listOfResponsibleBy,
    ));
  }
}

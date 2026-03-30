
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unistal_smart_gas_net/ExportFile/app_export_file.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/editHindrance/helper/edit_hindrance_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/domain/model/HindranceListModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';
import 'package:intl/intl.dart';

import 'edit_hindrance_event.dart';
import 'edit_hindrance_state.dart';

class EditHindranceBloc extends Bloc<EditHindranceEvent, EditHindranceState> {


  bool isLoader = false;
  File file = File("");

  String hindranceId = "";
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController hindranceCategoryCtrl = TextEditingController();
  TextEditingController hindranceTypeCtrl = TextEditingController();
  TextEditingController activityAffectedCtrl = TextEditingController();
  TextEditingController responsibleByCtrl = TextEditingController();
  TextEditingController reportNumberCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController chainageFromCtrl = TextEditingController();
  TextEditingController chainageToCtrl = TextEditingController();
  TextEditingController lengthCtrl = TextEditingController();
  TextEditingController resolutionDateCtrl = TextEditingController();
  TextEditingController resolutionNotesCtrl = TextEditingController();
  TextEditingController resolutionEditNotesCtrl = TextEditingController();

  LoginDataModel _userData = LoginDataModel();
  LoginDataModel get userData => _userData;

  HindranceListData hindranceListData = HindranceListData();
  

  EditHindranceBloc() : super(EditHindranceInitial()) {
    on<EditHindrancePageLoadEvent>(_pageLoad);
    on<EditHindranceResolutionCloseDateEvent>(_selectResolutionCloseDate);
    on<SelectCameraCaptureEvent>(_selectCameraCapture);
    on<SelectGalleryCaptureEvent>(_selectGalleryCapture);
    on<EditHindranceSubmitDataEvent>(_submitData);
  }

  _pageLoad(EditHindrancePageLoadEvent event, emit) async {
    emit(EditHindrancePageLoadState());
    isLoader = false;
    file = File("");
    dateCtrl = TextEditingController();
     hindranceCategoryCtrl = TextEditingController();
     hindranceTypeCtrl = TextEditingController();
     activityAffectedCtrl = TextEditingController();
     responsibleByCtrl = TextEditingController();
    reportNumberCtrl = TextEditingController();
    locationCtrl = TextEditingController();
    chainageFromCtrl = TextEditingController();
    chainageToCtrl = TextEditingController();
    lengthCtrl = TextEditingController();
    resolutionDateCtrl = TextEditingController();
    resolutionNotesCtrl = TextEditingController();

    _userData = UserInfo.instanceInit()!.userData!;
     hindranceListData = await  AppConfig.instanceInit()!.hindranceListData;
    hindranceId =  hindranceListData.id.toString();
    dateCtrl.text = hindranceListData.reportDate.toString();
    hindranceCategoryCtrl.text = hindranceListData.hindranceCategoryName.toString();
    hindranceTypeCtrl.text = hindranceListData.hindranceTypeName.toString();
    activityAffectedCtrl.text = hindranceListData.activityAffected.toString();
    responsibleByCtrl.text = hindranceListData.responsibleBy.toString();
    reportNumberCtrl.text = hindranceListData.reportNo.toString();
    locationCtrl.text = hindranceListData.location.toString();
    chainageFromCtrl.text = hindranceListData.chainageFrom.toString();
    chainageToCtrl.text = hindranceListData.chainageTo.toString();
    resolutionNotesCtrl.text = hindranceListData.reason.toString();
    double chainageFrom = double.tryParse(chainageFromCtrl.text.toString()) ?? 0.0;
    double chainageTo = double.tryParse(chainageToCtrl.text.toString()) ?? 0.0;
    double length = chainageTo - chainageFrom;
    lengthCtrl.text = length.toString();
    resolutionDateCtrl.text = "";
    resolutionEditNotesCtrl.text = "";
    _eventComplete(emit);
  }

  _selectResolutionCloseDate(EditHindranceResolutionCloseDateEvent event, emit) async {

    DateTime reportDate = DateTime.parse(dateCtrl.text.toString()); // API value
    DateTime currentDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: event.context,
      initialDate: currentDate,
      firstDate: reportDate,
      lastDate: currentDate,
    );

    if (pickedDate != null) {
      String formattedDateChange =
      DateFormat('yyyy-MM-dd').format(pickedDate);

      resolutionDateCtrl.text = formattedDateChange;
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

  _submitData(EditHindranceSubmitDataEvent event, emit) async {
    var textFiledValidation = await EditHindranceHelper.textFiledValidation(
      context: event.context,
      resolutionDate:  resolutionDateCtrl.text.toString(),
    );
    if (textFiledValidation == false) {
      return;
    }
    isLoader = true;
    _eventComplete(emit);
    var res = await EditHindranceHelper.submitData(
      context: event.context,
      userData: userData,
      id: hindranceId.toString(),
      date: hindranceListData.reportDate.toString(),
      reportNo: hindranceListData.reportNo.toString(),
      chainageFrom: hindranceListData.chainageFrom.toString(),
      locationAdd: hindranceListData.location.toString(),
      chainageTo: hindranceListData.chainageTo.toString(),
      activityAffected: hindranceListData.activityAffected.toString(),
      hindranceCategory: hindranceListData.hindranceCategory.toString(),
      hindranceType: hindranceListData.hindranceType.toString(),
      responsibleBy: hindranceListData.responsibleBy.toString(),
      resolutionNotes: hindranceListData.reason.toString(),
      resolutionDate: resolutionDateCtrl.text.toString(),
      resolutionEditNotes: resolutionEditNotesCtrl.text.toString(),
      file: file,
    );
    isLoader = false;
    _eventComplete(emit);
    if (res != null) {
      isLoader = false;
      file = File("");
      dateCtrl = TextEditingController();
      hindranceCategoryCtrl = TextEditingController();
      hindranceTypeCtrl = TextEditingController();
      activityAffectedCtrl = TextEditingController();
      responsibleByCtrl = TextEditingController();
      reportNumberCtrl = TextEditingController();
      locationCtrl = TextEditingController();
      chainageFromCtrl = TextEditingController();
      chainageToCtrl = TextEditingController();
      lengthCtrl = TextEditingController();
      resolutionDateCtrl = TextEditingController();
      resolutionNotesCtrl = TextEditingController();
      resolutionEditNotesCtrl = TextEditingController();
      _eventComplete(emit);
    }
  }

  _eventComplete(Emitter<EditHindranceState> emit) {
    emit(FetchEditHindranceDataState(
      isLoader: isLoader,
      file: file,
      dateCtrl: dateCtrl,
      activityAffectedCtrl: activityAffectedCtrl,
      hindranceCategoryCtrl: hindranceCategoryCtrl,
      hindranceTypeCtrl: hindranceTypeCtrl,
      responsibleByCtrl: responsibleByCtrl,
      reportNumberCtrl: reportNumberCtrl,
      locationCtrl: locationCtrl,
      chainageFromCtrl: chainageFromCtrl,
      chainageToCtrl: chainageToCtrl,
      lengthCtrl: lengthCtrl,
      resolutionDateCtrl: resolutionDateCtrl,
      resolutionNotesCtrl: resolutionNotesCtrl,
      resolutionEditNotesCtrl: resolutionEditNotesCtrl,
    ));
  }
}

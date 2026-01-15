import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/section_id/domain/bloc/section_id_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/section_id/domain/bloc/section_id_state.dart';
import 'package:flutter_unistal_smart_gas_net/feature/section_id/helper/section_id_helper.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';

class SectionIdBloc extends Bloc<SectionIdEvent, SectionIdState> {
  SectionIdBloc() : super(SectionIdInitialState()) {
    on<SectionIdPageLoadEvent>(_pageLoad);
  }

  bool isPageLoader = false;

  LoginDataModel _userData = UserInfo.instance!.userData!;
  LoginDataModel get userData => _userData;

  List<ActivitySectionData> listActivityData = [];
  List<ActivitySectionData> filteredList  = [];


  _pageLoad(SectionIdPageLoadEvent event, emit) async {
    emit(SectionIdInitialState());
    isPageLoader = false;
    listActivityData = [];
    _userData = UserInfo.instance!.userData!;
    listActivityData = await SectionIdHelper.activityBySectionApi(userData: userData) ?? [];

    final Map<String, ActivitySectionData> sectionMap = {};

    for (final item in listActivityData) {
      sectionMap[item.sectionId.toString()] ??= item;
    }

    filteredList = sectionMap.values.toList();
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<SectionIdState> emit) {
    emit(
      SectionIdDataState(
        isPageLoader: isPageLoader,
        listActivityData: filteredList,
      ),
    );
  }
}

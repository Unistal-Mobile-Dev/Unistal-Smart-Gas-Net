import 'package:bloc/bloc.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/helper/home_helper.dart';
import 'package:flutter_unistal_smart_gas_net/feature/login/domain/models/login_model.dart';
import 'package:flutter_unistal_smart_gas_net/feature/web_dashboard/domain/bloc/web_dashboard_event.dart';
import 'package:flutter_unistal_smart_gas_net/feature/web_dashboard/domain/bloc/web_dashboard_state.dart';
import 'package:flutter_unistal_smart_gas_net/utils/commonClass/user_info.dart';

class WebDashboardBloc extends Bloc<WebDashboardEvent, WebDashboardState> {
  WebDashboardBloc() : super(WebDashboardInitialState()) {
    on<WebDashboardPageLoadEvent>(_pageLoad);
  }

  final LoginDataModel _userData = UserInfo.instance!.userData!;
  LoginDataModel get userData => _userData;

  List<ActivitySectionData> listActivityData = [];

    _pageLoad(WebDashboardPageLoadEvent event, emit) async {
      emit(WebDashboardPageLoadState());
      listActivityData = await HomeHelper.activityBySectionApi(userData: userData) ?? [];
      _eventCompleted(emit);
    }


  _eventCompleted(Emitter<WebDashboardState> emit) {
    emit(FetchWebDashboardDataState(
      listActivityData: listActivityData
    ));
  }
}

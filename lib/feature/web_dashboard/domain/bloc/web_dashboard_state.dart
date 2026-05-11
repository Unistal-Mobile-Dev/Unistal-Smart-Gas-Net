import 'package:equatable/equatable.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';

class WebDashboardState  extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WebDashboardInitialState  extends WebDashboardState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WebDashboardPageLoadState  extends WebDashboardInitialState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class FetchWebDashboardDataState extends WebDashboardInitialState {
  final List<ActivitySectionData> listActivityData;

  FetchWebDashboardDataState({required this.listActivityData});

  @override
  List<Object> get props => [listActivityData];
}

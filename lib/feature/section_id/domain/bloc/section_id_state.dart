import 'package:equatable/equatable.dart';
import 'package:flutter_unistal_smart_gas_net/feature/home/domain/model/ActivitySectionModel.dart';


abstract class SectionIdState extends Equatable {}

class SectionIdInitialState extends SectionIdState {
  @override
  List<Object> get props => [];
}

class SectionIdPageLoadState extends SectionIdState {
  @override
  List<Object> get props => [];
}

class SectionIdDataState extends SectionIdState {
  final bool isPageLoader;
  final List<ActivitySectionData> listActivityData;


  SectionIdDataState({
    required this.isPageLoader,
    required this.listActivityData,

  });

  @override
  List<Object> get props => [isPageLoader,listActivityData];
}

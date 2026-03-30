import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_unistal_smart_gas_net/feature/Hindrance/viewHindrance/domain/model/HindranceListModel.dart';

abstract class ViewHindranceState extends Equatable {
  const ViewHindranceState();
}

class ViewHindranceInitial extends ViewHindranceState {
  @override
  List<Object> get props => [];
}

class ViewHindrancePageLoadState extends ViewHindranceInitial {
  @override
  List<Object> get props => [];
}

class FetchViewHindranceDataState extends ViewHindranceInitial {
  final bool isLoader;
  final bool isHindranceSearch;
  final TextEditingController searchingCtrl;
  final List<HindranceListData> listOfHindranceTableData;

  FetchViewHindranceDataState({
    required this.isLoader,
    required this.isHindranceSearch,
    required this.searchingCtrl,
    required this.listOfHindranceTableData,
  });

  @override
  List<Object> get props => [
        isLoader,
        isHindranceSearch,
        searchingCtrl,
        listOfHindranceTableData,
      ];
}

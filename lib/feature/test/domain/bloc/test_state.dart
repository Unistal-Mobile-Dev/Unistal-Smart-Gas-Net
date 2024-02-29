part of 'test_bloc.dart';

abstract class TestState extends Equatable {
  const TestState();
}

class TestInitial extends TestState {
  @override
  List<Object> get props => [];
}

class TestPageLoadState extends TestInitial {
  @override
  List<Object> get props => [];
}


class FetchTestDataState extends TestInitial {
  final List<TestModel> testList;
  FetchTestDataState({required this.testList});
  @override
  List<Object> get props => [testList];
}

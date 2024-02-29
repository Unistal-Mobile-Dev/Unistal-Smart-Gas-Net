part of 'test_bloc.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();
}

class TestPageLoadEvent extends TestEvent {
  final BuildContext context;
  const TestPageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class TestPageSelectAlignmentData extends TestEvent {
  final List<TestModel> testList;
  final BuildContext context;
  const TestPageSelectAlignmentData({required this.testList, required this.context});

  @override
  List<Object?> get props => [testList, context];
}
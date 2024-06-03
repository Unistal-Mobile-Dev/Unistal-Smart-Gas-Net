import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_route_survey_event.dart';

part 'view_route_survey_state.dart';

class ViewRouteSurveyBloc
    extends Bloc<ViewRouteSurveyEvent, ViewRouteSurveyState> {
  ViewRouteSurveyBloc() : super(ViewRouteSurveyInitial()) {
    on<ViewRouteSurveyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

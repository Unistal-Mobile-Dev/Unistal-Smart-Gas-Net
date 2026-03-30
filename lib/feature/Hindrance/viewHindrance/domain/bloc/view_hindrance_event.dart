
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ViewHindranceEvent extends Equatable {
  const ViewHindranceEvent();
}

class ViewHindrancePageLoadEvent extends ViewHindranceEvent {
  final BuildContext context;

  const ViewHindrancePageLoadEvent({required this.context});

  @override
  List<Object?> get props => [context];
}


class ViewHindranceSearchingEvent extends ViewHindranceEvent {
  final String searching;
  final BuildContext context;

  const ViewHindranceSearchingEvent({
    required this.searching,
    required this.context,
  });

  @override
  List<Object?> get props => [searching,context];
}



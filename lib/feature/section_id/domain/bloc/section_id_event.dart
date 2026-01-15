import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SectionIdEvent extends Equatable{}

class SectionIdPageLoadEvent extends SectionIdEvent {
  final BuildContext context;
  SectionIdPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

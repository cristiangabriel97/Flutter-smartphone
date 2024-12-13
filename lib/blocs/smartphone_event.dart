import 'package:equatable/equatable.dart';

abstract class SmartphoneEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSmartphones extends SmartphoneEvent {}

class AddSmartphone extends SmartphoneEvent {
  final Map<String, dynamic> smartphoneData;

  AddSmartphone(this.smartphoneData);

  @override
  List<Object?> get props => [smartphoneData];
}

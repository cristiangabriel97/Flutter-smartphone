import 'package:equatable/equatable.dart';

abstract class SmartphoneState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SmartphoneInitial extends SmartphoneState {}

class SmartphoneLoading extends SmartphoneState {}

class SmartphoneLoaded extends SmartphoneState {
  final List<Map<String, dynamic>> smartphones;

  SmartphoneLoaded(this.smartphones);

  @override
  List<Object?> get props => [smartphones];
}

class SmartphoneError extends SmartphoneState {
  final String message;

  SmartphoneError(this.message);

  @override
  List<Object?> get props => [message];
}

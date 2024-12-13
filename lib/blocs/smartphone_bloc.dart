import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartphone_app/repositories/smartphone_repository.dart';
import 'smartphone_event.dart';
import 'smartphone_state.dart';

class SmartphoneBloc extends Bloc<SmartphoneEvent, SmartphoneState> {
  final SmartphoneRepository smartphoneRepository;

  SmartphoneBloc({required this.smartphoneRepository})
      : super(SmartphoneInitial()) {
    on<LoadSmartphones>(_onLoadSmartphones);
    on<AddSmartphone>(_onAddSmartphone);
  }

  void _onLoadSmartphones(
      LoadSmartphones event, Emitter<SmartphoneState> emit) async {
    try {
      emit(SmartphoneLoading());
      final stream = smartphoneRepository.getSmartphones();
      await emit.forEach<List<Map<String, dynamic>>>(
        stream,
        onData: (data) => SmartphoneLoaded(data),
        onError: (error, _) => SmartphoneError(error.toString()),
      );
    } catch (e) {
      emit(SmartphoneError(e.toString()));
    }
  }

  void _onAddSmartphone(
      AddSmartphone event, Emitter<SmartphoneState> emit) async {
    try {
      await smartphoneRepository.addSmartphone(event.smartphoneData);
    } catch (e) {
      emit(SmartphoneError(e.toString()));
    }
  }
}

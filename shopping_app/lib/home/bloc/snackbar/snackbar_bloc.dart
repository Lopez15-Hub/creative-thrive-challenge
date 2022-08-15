import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

part 'snackbar_event.dart';
part 'snackbar_state.dart';

class SnackbarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  SnackbarBloc() : super(SnackbarInitial()) {
    on<SnackbarSuccessEvent>((event, emit) {
      ScaffoldMessenger.of(event.context).showSnackBar(customSnackbarWidget(
          event.context,
          snackbarColor: Colors.green,
          snackbarIcon: const Icon(Icons.check_circle),
          snackbarTitle: event.successMessage,
          snackbarDuration: 3));
    });
    on<SnackbarInfoEvent>((event, emit) {
      ScaffoldMessenger.of(event.context).showSnackBar(customSnackbarWidget(
          event.context,
          snackbarColor: Colors.blue,
          snackbarIcon: const Icon(Icons.info),
          snackbarTitle: event.infoMessage,
          snackbarDuration: 3));
    });
    on<SnackbarWarningEvent>((event, emit) {
      ScaffoldMessenger.of(event.context).showSnackBar(customSnackbarWidget(
          event.context,
          snackbarColor: Colors.yellow,
          snackbarIcon: const Icon(Icons.warning),
          snackbarTitle: event.warningMessage,
          snackbarDuration: 3));
    });
    on<SnackbarErrorEvent>((event, emit) {
      ScaffoldMessenger.of(event.context).showSnackBar(customSnackbarWidget(
          event.context,
          snackbarColor: Colors.red,
          snackbarIcon: const Icon(Icons.error),
          snackbarTitle: event.errorMessage,
          snackbarDuration: 3));
    });
  }
}

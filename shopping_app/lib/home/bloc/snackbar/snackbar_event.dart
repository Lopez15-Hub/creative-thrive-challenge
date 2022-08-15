part of 'snackbar_bloc.dart';

@immutable
abstract class SnackbarEvent extends Equatable {
  final BuildContext context;

  const SnackbarEvent(this.context);
}

class SnackbarSuccessEvent extends SnackbarEvent {
  final String successMessage;
  const SnackbarSuccessEvent(super.context, this.successMessage);
  @override
  List<Object> get props => [context];
}

class SnackbarInfoEvent extends SnackbarEvent {
  final String infoMessage;
  const SnackbarInfoEvent(super.context, this.infoMessage);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SnackbarWarningEvent extends SnackbarEvent {
  final String warningMessage;
  const SnackbarWarningEvent(super.context, this.warningMessage);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SnackbarErrorEvent extends SnackbarEvent {
  final String errorMessage;
  const SnackbarErrorEvent(super.context, this.errorMessage);

  @override
  List<Object?> get props => throw UnimplementedError();
}

import 'package:equatable/equatable.dart';

abstract class CommonState<T> extends Equatable {}

class UninitializedState extends CommonState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends CommonState {
  @override
  List<Object> get props => [];
}

class SuccessState<T> extends CommonState<T> {
  SuccessState(this.data);

  final T data;

  @override
  List<T> get props => [data];
}

class ErrorState extends CommonState {
  ErrorState(this.error);

  final Error error;

  @override
  List<Object> get props => [error];
}

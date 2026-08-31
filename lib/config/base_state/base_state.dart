import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  const BaseState({this.isLoading = false, this.data, this.errorMessage});

  final bool? isLoading;
  final T? data;
  final String? errorMessage;

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}

import 'package:equatable/equatable.dart';
import 'package:test_commerce/data/model/product_model.dart';

abstract class ProductState extends Equatable {}

class UninitializedState extends ProductState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class SuccessState extends ProductState {
  SuccessState(this.data);

  final ProductCategoriesModel data;

  @override
  List<Object> get props => [data];
}

class ErrorState extends ProductState {
  ErrorState(this.error);

  final Error error;

  @override
  List<Object> get props => [error];
}

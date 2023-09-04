import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetProductByCategoriesEvent extends ProductEvent {
  const GetProductByCategoriesEvent({required this.category});

  final String category;

  @override
  List<Object?> get props => [category];
}

class GetProductEvent extends ProductEvent {}

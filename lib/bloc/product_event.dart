import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetProductCategoriesEvent extends ProductEvent {
  const GetProductCategoriesEvent({required this.category});
  final String category;

  @override
  List<Object?> get props => [category];
}

class GetProductEvent extends ProductEvent {

}

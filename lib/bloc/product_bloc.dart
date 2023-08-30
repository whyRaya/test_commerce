import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_commerce/bloc/product_event.dart';
import 'package:test_commerce/bloc/product_state.dart';
import 'package:test_commerce/data/model/product_model.dart';
import 'package:test_commerce/data/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(UninitializedState()) {
    on<GetProductEvent>(onGetHomeProduct);
  }
  //
  // void onGetProduct(GetProductEvent event, Emitter<ProductState> emit) async {
  //   emit(LoadingState());
  //   await _productRepository
  //       .getProduct()
  //       .then((product) => {emit(SuccessState(product))})
  //       .catchError((error, stackTrace) {
  //     emit(ErrorState(error));
  //     Future.error(error);
  //   });
  // }

  void onGetHomeProduct(
      GetProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    await Future.wait([
      _productRepository.getCategories(),
      _productRepository.getProduct()
    ]).then(
      (value) => {
        emit(SuccessState(
          ProductCategoriesModel(
            categories: value.first as List<String>,
            products: value.last as List<ProductModel>,
          ),
        ))
      },
    ).catchError((error, stackTrace) {
      emit(ErrorState(error));
      Future.error(error);
    });
  }

  final ProductRepository _productRepository;
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_commerce/bloc/product_event.dart';
import 'package:test_commerce/bloc/product_state.dart';
import 'package:test_commerce/data/model/product_model.dart';
import 'package:test_commerce/data/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, CommonState> {
  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(UninitializedState()) {
    on<GetProductEvent>(onGetHomeProduct);
  }

  void onGetHomeProduct(
      GetProductEvent event, Emitter<CommonState> emit) async {
    emit(LoadingState());
    await Future.wait([
      _productRepository.getCategories(),
      _productRepository.getProduct()
    ]).then(
      (value) => {
        emit(SuccessState<ProductCategoriesModel>(
          ProductCategoriesModel(
            categories: value.first as List<String>,
            products: value.last as List<ProductModel>,
          ),
        ))
      },
    ).catchError((error, stackTrace) {
      emit(ErrorState(error));
      return <void>{};
    });
  }

  final ProductRepository _productRepository;
}

class ProductCategoriesBloc extends Bloc<ProductEvent, CommonState> {
  ProductCategoriesBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(UninitializedState()) {
    on<GetProductByCategoriesEvent>(onGetProductByCategory);
  }

  void onGetProductByCategory(
      GetProductByCategoriesEvent event, Emitter<CommonState> emit) async {
    emit(LoadingState());
    await _productRepository.getProductByCategory(event.category).then(
          (value) => {
        emit(SuccessState(value))
      },
    ).catchError((error, stackTrace) {
      emit(ErrorState(error));
      throw Exception('An error occurred during data fetching: $error');
    });
  }

  final ProductRepository _productRepository;
}

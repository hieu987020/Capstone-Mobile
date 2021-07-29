import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailFetchInitial());
  final ProductRepository _productsRepository = new ProductRepository();
  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is ProductDetailInitialEvent) {
      yield ProductDetailFetchInitial();
    }
    if (event is ProductDetailFetchEvent) {
      yield* _getProductsDetail(event.productId);
    }
  }

  Stream<ProductDetailState> _getProductsDetail(String productName) async* {
    try {
      yield ProductDetailLoading();
      final product = await _productsRepository.getProduct(productName);
      yield ProductDetailLoaded(product);
    } catch (e) {
      yield ProductDetailError();
    }
  }
}

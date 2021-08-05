import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductFetchInitial());
  final ProductRepository productRepository = new ProductRepository();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductFetchInitial) {
      _getProducts(StatusIntBase.All);
    } else if (event is ProductFetchEvent) {
      yield* _getProducts(event.statusId);
    } else if (event is ProductSearchEvent) {
      yield* _searchProducts(event.productName);
    }
  }

  Stream<ProductState> _getProducts(int statusId) async* {
    try {
      yield ProductLoading();

      final products = await productRepository.getProducts(
          SearchValueBase.Default,
          SearchFieldBase.Default,
          PageNumBase.Default,
          FetchNextBase.Default,
          statusId);
      yield ProductLoaded(products);
    } catch (e) {
      yield ProductError();
    }
  }

  Stream<ProductState> _searchProducts(String productName) async* {
    try {
      yield ProductLoading();
      final products =
          await productRepository.getProductsByProductName(productName);
      yield ProductLoaded(products);
    } catch (e) {
      yield ProductError();
    }
  }
}

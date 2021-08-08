import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailFetchInitial());
  final ProductRepository _productsRepository = new ProductRepository();
  final StoreRepository _storeRepository = new StoreRepository();
  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is ProductDetailInitialEvent) {
      yield ProductDetailFetchInitial();
    }
    if (event is ProductDetailFetchEvent) {
      yield* _getProductsDetail(event.productId);
    }
  }

  Stream<ProductDetailState> _getProductsDetail(String productId) async* {
    try {
      yield ProductDetailLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String roleName = prefs.get("roleName");
      if (roleName == StatusStringAuth.Admin) {
        var product = await _productsRepository.getProduct(productId);
        var stores = await _storeRepository.getStoresByProduct(
            SearchValueBase.Default,
            SearchFieldBase.Default,
            PageNumBase.Default,
            FetchNextBase.Default,
            StatusIntBase.All,
            productId);
        yield ProductDetailLoaded(product, stores);
      } else {
        var product = await _productsRepository.getProduct(productId);
        yield ProductDetailLoaded(product, null);
      }
    } catch (e) {
      yield ProductDetailError();
    }
  }
}

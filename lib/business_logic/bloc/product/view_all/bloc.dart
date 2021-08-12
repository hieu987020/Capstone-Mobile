import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState());
  final ProductRepository productRepository = new ProductRepository();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductFetchInitial) {
      yield ProductInitialState();
    } else if (event is ProductFetchEvent) {
      yield* _getProducts(event.searchValue, event.searchField, event.pageNum,
          event.fetchNext, event.categoryId, event.statusId);
    } else if (event is ProductAllEvent) {
      yield* _getAllProducts();
    }
  }

  Stream<ProductState> _getProducts(String searchValue, String searchField,
      int pageNum, int fetchNext, int categoryId, int statusId) async* {
    try {
      yield ProductLoading();

      final products = await productRepository.getProducts(
          searchValue, searchField, pageNum, fetchNext, categoryId, statusId);
      yield ProductLoaded(products);
    } catch (e) {
      yield ProductError();
    }
  }

  Stream<ProductState> _getAllProducts() async* {
    try {
      yield ProductLoading();
      final products = await productRepository.getAll();
      yield ProductLoaded(products);
    } catch (e) {
      yield ProductError();
    }
  }
}

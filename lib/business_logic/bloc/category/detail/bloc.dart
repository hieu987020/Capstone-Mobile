import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  CategoryDetailBloc() : super(CategoryDetailFetchInitial());
  final CategoryRepository _cateRepository = new CategoryRepository();
  final ProductRepository _productRepository = new ProductRepository();
  @override
  Stream<CategoryDetailState> mapEventToState(
      CategoryDetailEvent event) async* {
    if (event is CategoryDetailInitialEvent) {
      yield CategoryDetailFetchInitial();
    }
    if (event is CategoryDetailFetchEvent) {
      yield* _getCategorysDetail(event.categoryId);
    }
  }

  Stream<CategoryDetailState> _getCategorysDetail(int categoryId) async* {
    try {
      yield CategoryDetailLoading();
      var category = await _cateRepository.getCategory(categoryId);
      var products = await _productRepository.getProducts(
        SearchValueBase.Default,
        SearchFieldBase.Default,
        PageNumBase.Default,
        FetchNextBase.Default,
        categoryId,
        StatusIntBase.All,
      );
      yield CategoryDetailLoaded(category, products);
    } catch (e) {
      yield CategoryDetailError();
    }
  }
}

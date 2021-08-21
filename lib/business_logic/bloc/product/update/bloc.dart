import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductUpdateBloc extends Bloc<ProductUpdateEvent, ProductUpdateState> {
  ProductUpdateBloc() : super(ProductUpdateInitial());

  final ProductRepository _productsRepository = new ProductRepository();

  @override
  Stream<ProductUpdateState> mapEventToState(ProductUpdateEvent event) async* {
    if (event is ProductUpdateShowForm) {
      yield ProductUpdateInitial();
    }
    if (event is ProductUpdateSubmit) {
      yield* _updateProduct(event.product);
    }
  }

  Stream<ProductUpdateState> _updateProduct(Product product) async* {
    try {
      yield ProductUpdateLoading();
      String result = await _productsRepository.updateProduct(product);
      print(result);
      if (result == 'true') {
        yield ProductUpdateLoaded();
      } else {
        yield ProductUpdateError(result);
      }
    } catch (e) {
      yield ProductUpdateError("System can not finish this action");
    }
  }
}

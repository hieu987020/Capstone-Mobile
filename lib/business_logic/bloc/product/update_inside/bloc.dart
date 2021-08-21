import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductUpdateInsideBloc
    extends Bloc<ProductUpdateInsideEvent, ProductUpdateInsideState> {
  ProductUpdateInsideBloc() : super(ProductUpdateInsideInitial());
  final ProductRepository _productRepository = new ProductRepository();
  @override
  Stream<ProductUpdateInsideState> mapEventToState(
      ProductUpdateInsideEvent event) async* {
    if (event is ProductUpdateInsideEvent) {
      yield ProductUpdateInsideInitial();
    }
    if (event is ProductChangeStatus) {
      yield* _cameraChangeStatus(
          event.productId, event.statusId, event.reasonInactive);
    }
  }

  Stream<ProductUpdateInsideState> _cameraChangeStatus(
      String productId, int statusId, String reasonInactive) async* {
    try {
      yield ProductUpdateInsideLoading();
      String response = await _productRepository.changeStatus(
          productId, statusId, reasonInactive);
      if (response == 'true') {
        yield ProductUpdateInsideLoaded();
      } else {
        yield ProductUpdateInsideError(response);
      }
    } catch (e) {
      yield ProductUpdateInsideError("System can not finish this action");
    }
  }
}

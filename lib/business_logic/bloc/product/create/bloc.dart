import 'dart:async';
import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCreateBloc extends Bloc<ProductCreateEvent, ProductCreateState> {
  ProductCreateBloc() : super(ProductCreateInitial());
  final ProductRepository _productsRepository = new ProductRepository();
  final ImageRepository _imageRepository = new ImageRepository();
  @override
  Stream<ProductCreateState> mapEventToState(ProductCreateEvent event) async* {
    if (event is ProductCreateInitialEvent) {
      yield ProductCreateInitial();
    }
    if (event is ProductCreateSubmitEvent) {
      yield* _createProduct(event.product, event.imageFile);
    }
  }

  Stream<ProductCreateState> _createProduct(
      Product product, File imageFile) async* {
    try {
      yield ProductCreateLoading();
      if (imageFile != null) {
        String imageResult = await _imageRepository.postImage(imageFile);
        product = product.copyWith(
          productName: product.productName,
          imageUrl: imageResult,
          categories: product.categories,
          description: product.description,
        );
      }
      String result = await _productsRepository.postProduct(product);
      if (result == 'true') {
        yield ProductCreateLoaded();
      } else {
        yield ProductCreateError(result);
      }
    } catch (e) {
      yield ProductCreateError(e.toString());
    }
  }
}

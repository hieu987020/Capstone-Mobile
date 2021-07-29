import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/image_repository.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductUpdateImageBloc
    extends Bloc<ProductUpdateImageEvent, ProductUpdateImageState> {
  ProductUpdateImageBloc() : super(ProductUpdateImageInitial());

  final ProductRepository _productRepository = new ProductRepository();
  final ImageRepository _imageRepository = new ImageRepository();

  @override
  Stream<ProductUpdateImageState> mapEventToState(
      ProductUpdateImageEvent event) async* {
    if (event is ProductUpdateImageInitialEvent) {
      yield ProductUpdateImageInitial();
    }
    if (event is ProductUpdateImageSubmit) {
      yield* _updateImage(event.product, event.imageFile);
    }
  }

  Stream<ProductUpdateImageState> _updateImage(
      Product product, File imageFile) async* {
    try {
      yield ProductUpdateImageLoading();
      if (imageFile != null) {
        String imageResult = await _imageRepository.postImage(imageFile);
        product = product.copyWith(
          productId: product.productId,
          productName: product.productName,
          imageUrl: imageResult,
          description: product.description,
        );
      }
      String result = await _productRepository.updateProduct(product);
      print(result);
      if (result == 'true') {
        yield ProductUpdateImageLoaded();
      } else if (result.contains('errorCodeAndMsg')) {
        yield ProductUpdateImageError(result);
      }
    } catch (e) {
      yield ProductUpdateImageError(e);
    }
  }
}

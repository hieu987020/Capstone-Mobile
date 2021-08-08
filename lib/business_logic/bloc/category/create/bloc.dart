import 'dart:async';
import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCreateBloc
    extends Bloc<CategoryCreateEvent, CategoryCreateState> {
  CategoryCreateBloc() : super(CategoryCreateInitial());
  final CategoryRepository _camerasRepository = new CategoryRepository();
  @override
  Stream<CategoryCreateState> mapEventToState(
      CategoryCreateEvent event) async* {
    if (event is CategoryCreateInitialEvent) {
      yield CategoryCreateInitial();
    }
    if (event is CategoryCreateSubmitEvent) {
      yield* _createCategory(event.category);
    }
  }

  Stream<CategoryCreateState> _createCategory(Category category) async* {
    try {
      yield CategoryCreateLoading();
      String result = await _camerasRepository.postCategory(category);
      if (result == 'true') {
        yield CategoryCreateLoaded();
      } else {
        yield CategoryCreateError(result);
      }

      // else if (result.contains("MSG-059")) {
      //   yield CategoryCreateDuplicatedName("Category is existed");
      // } else if (result.contains('errorCodeAndMsg')) {
      //   yield CategoryCreateError(result);
      // }
    } catch (e) {
      yield CategoryCreateError("System can not finish this action");
    }
  }
}

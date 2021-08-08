import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:capstone/data/repositories/camera_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryUpdateBloc
    extends Bloc<CategoryUpdateEvent, CategoryUpdateState> {
  CategoryUpdateBloc() : super(CategoryUpdateInitial());

  final CategoryRepository _categoryRepository = new CategoryRepository();

  @override
  Stream<CategoryUpdateState> mapEventToState(
      CategoryUpdateEvent event) async* {
    if (event is CategoryUpdateInitialEvent) {
      yield CategoryUpdateInitial();
    }
    if (event is CategoryUpdateSubmit) {
      yield* _updateCategory(event.cate);
    }
  }

  Stream<CategoryUpdateState> _updateCategory(Category cate) async* {
    try {
      yield CategoryUpdateLoading();
      String result = await _categoryRepository.updateCategory(cate);
      print(result);
      if (result == 'true') {
        yield CategoryUpdateLoaded();
      } else {
        yield CategoryUpdateError(result);
      }
    } catch (e) {
      yield CategoryUpdateError(e);
    }
  }
}

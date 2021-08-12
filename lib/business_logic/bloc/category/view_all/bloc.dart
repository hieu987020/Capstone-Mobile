import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitialState());
  final CategoryRepository categoryRepository = new CategoryRepository();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoryFetchInitial) {
      yield CategoryInitialState();
    } else if (event is CategoryFetchEvent) {
      yield* _getCategorys(event.searchValue, event.searchField,
          event.fetchNext, event.pageNum, event.statusId);
    }
  }

  Stream<CategoryState> _getCategorys(String searchValue, String searchField,
      int pageNum, int fetchNext, int statusId) async* {
    try {
      yield CategoryLoading();
      final categories = await categoryRepository.getCategories(
        searchValue,
        searchField,
        pageNum,
        fetchNext,
        statusId,
      );

      yield CategoryLoaded(categories);
    } catch (e) {
      yield CategoryError();
    }
  }
}

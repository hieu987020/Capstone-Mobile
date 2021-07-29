import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone/business_logic/bloc/bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryFetchInitial());
  final CategoryRepository categoryRepository = new CategoryRepository();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoryFetchInitial) {
      _getCategorys(StatusIntBase.All);
    } else if (event is CategoryFetchEvent) {
      yield* _getCategorys(event.statusId);
    }
  }

  Stream<CategoryState> _getCategorys(int statusId) async* {
    try {
      yield CategoryLoading();
      final categories = await categoryRepository.getCategories(
        SearchValueBase.Default,
        SearchFieldBase.Default,
        PageNumBase.Default,
        FetchNextBase.Default,
        statusId,
      );

      yield CategoryLoaded(categories);
    } catch (e) {
      yield CategoryError();
    }
  }
}

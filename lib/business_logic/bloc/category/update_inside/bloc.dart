import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryUpdateInsideBloc
    extends Bloc<CategoryUpdateInsideEvent, CategoryUpdateInsideState> {
  CategoryUpdateInsideBloc() : super(CategoryUpdateInsideInitial());
  final CategoryRepository _cateRepository = new CategoryRepository();
  @override
  Stream<CategoryUpdateInsideState> mapEventToState(
      CategoryUpdateInsideEvent event) async* {
    if (event is CategoryUpdateInsideEvent) {
      yield CategoryUpdateInsideInitial();
    }
    if (event is CategoryChangeStatus) {
      yield* _cameraChangeStatus(event.cateId, event.statusId);
    }
  }

  Stream<CategoryUpdateInsideState> _cameraChangeStatus(
      int cateId, int statusId) async* {
    try {
      yield CategoryUpdateInsideLoading();
      String response = await _cateRepository.changeStatus(cateId, statusId);
      if (response == 'true') {
        yield CategoryUpdateInsideLoaded();
      } else {
        yield CategoryUpdateInsideError(response);
      }
    } catch (e) {
      yield CategoryUpdateInsideError(e);
    }
  }
}

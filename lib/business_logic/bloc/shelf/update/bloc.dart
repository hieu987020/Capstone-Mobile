import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShelfUpdateBloc extends Bloc<ShelfUpdateEvent, ShelfUpdateState> {
  ShelfUpdateBloc() : super(ShelfUpdateInitial());

  final ShelfRepository _shelfRepository = new ShelfRepository();

  @override
  Stream<ShelfUpdateState> mapEventToState(ShelfUpdateEvent event) async* {
    if (event is ShelfUpdateShowForm) {
      yield ShelfUpdateInitial();
    }
    if (event is ShelfUpdateSubmit) {
      yield* _updateShelf(event.shelf);
    }
  }

  Stream<ShelfUpdateState> _updateShelf(Shelf shelf) async* {
    try {
      yield ShelfUpdateLoading();
      String result = await _shelfRepository.updateShelf(shelf);
      print(result);
      if (result == 'true') {
        yield ShelfUpdateLoaded();
      } else {
        yield ShelfUpdateError(result);
      }
    } catch (e) {
      yield ShelfUpdateError("System can not finish this action");
    }
  }
}

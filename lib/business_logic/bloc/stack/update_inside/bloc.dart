import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StackUpdateInsideBloc
    extends Bloc<StackUpdateInsideEvent, StackUpdateInsideState> {
  StackUpdateInsideBloc() : super(StackUpdateInsideInitial());
  final StackRepository stackRepository = new StackRepository();

  @override
  Stream<StackUpdateInsideState> mapEventToState(
      StackUpdateInsideEvent event) async* {
    if (event is StackUpdateInsideInitialEvent) {
      yield StackUpdateInsideInitial();
    }
    if (event is StackMapProductEvent) {
      yield* _mapProduct(event.stackId, event.productId, event.action);
    }
    if (event is StackMapCameraEvent) {
      yield* _mapCamera(event.stackId, event.cameraId, event.action);
    }
  }

  Stream<StackUpdateInsideState> _mapProduct(
      String stackId, String productId, int action) async* {
    try {
      yield StackUpdateInsideLoading();
      String response =
          await stackRepository.changeProduct(stackId, productId, action);
      if (response == 'true') {
        yield StackUpdateInsideLoaded();
      } else {
        yield StackUpdateInsideError(response);
      }
    } catch (e) {
      print("error trong stack update_inside bloc , map product ");
      print(e.toString());
      yield StackUpdateInsideError(e.toString());
    }
  }

  Stream<StackUpdateInsideState> _mapCamera(
      String stackId, String cameraId, int action) async* {
    try {
      yield StackUpdateInsideLoading();
      String response =
          await stackRepository.changeCamera(stackId, cameraId, action);
      if (response == 'true') {
        yield StackUpdateInsideLoaded();
      } else {
        yield StackUpdateInsideError(response);
      }
    } catch (e) {
      print("error trong stack update_inside bloc , map camera ");
      print(e.toString());
      yield StackUpdateInsideError(e.toString());
    }
  }
}

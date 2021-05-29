import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  // @override
  // void onEvent(Bloc bloc, Object event) {
  //   super.onEvent(bloc, event);
  //   print('onEvent $event');
  // }

  // @override
  // onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   print('onTransition $transition');
  // }

  // @override
  // void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
  //   print('onError $error');
  //   super.onError(bloc, error, stackTrace);
  // }
}

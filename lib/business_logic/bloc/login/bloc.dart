import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/data/repositories/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  LoginRepository _loginRepo = new LoginRepository();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInitialEvent) {
      yield LoginInitial();
    }
    if (event is LoginClickLoginButton) {
      yield* _login(event.loginModel);
    }
  }

  Stream<LoginState> _login(LoginModel loginModel) async* {
    try {
      yield LoginLoading();
      var loginmodel = await _loginRepo.login(loginModel);
      if (loginmodel != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', loginmodel.token);

        prefs.setString('roleName', loginmodel.roleName);
        String roleName = loginmodel.roleName;
        if (roleName == StatusStringAuth.Admin) {
          yield LoginAdminLoaded(loginmodel);
        } else if (roleName == StatusStringAuth.Manager) {
          if (loginmodel.statusId == 1) {
            prefs.setString('storeId', loginmodel.storeId);
            yield LoginManagerLoaded(loginmodel);
          } else if (loginmodel.statusId == 3) {
            yield LoginError("Oops! Something wrong happen");
          }
        }
      } else if (loginmodel == null) {
        yield LoginInvalid("Invalid username or password");
      }
    } catch (e) {
      print(e.toString());
      yield LoginError("System can not finish this action");
    }
  }
}

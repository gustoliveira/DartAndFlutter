import 'package:mobx/mobx.dart';
import 'package:email_validator/email_validator.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable // Atributos que vão sendo observados a esperando de uma mudança
  String email = "";

  @action // Quando os observáveis sofrem mudanças, eles chamam as ações
  void setEmail(value) => email = value;

  @observable
  bool showPassword = false;

  @action
  void setShowPassword() => showPassword = !showPassword;

  // Quando ações são chamadas, eles acionam as reações, que fazem algo determinado

  @observable
  String password = "";

  @action
  void setPassword(value) => password = value;

  // @computed deriva um estado a partir do estado de outro observable
  // No exemplo abaixo, isEmailValid só é true se o o observable email for de fato um email
  @computed
  bool get isEmailValid => EmailValidator.validate(email);

  @computed
  bool get isPasswordValid => password.length >= 6;

  @observable
  bool isLogging = false;

  @observable
  bool isLoged = false;

  @action
  Future<void> login() async {
    isLogging = true;

    await Future.delayed(Duration(seconds: 2));
    isLogging = false;
    isLoged = true;
  }

  @computed
  Function get loginPressed => (isEmailValid && isPasswordValid && !isLogging) ? login : null;

}

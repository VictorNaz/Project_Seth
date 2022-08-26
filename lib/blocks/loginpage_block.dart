import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_project_seth/validators/loginValidators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBlock extends BlocBase with LoginValidators {
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();

//Recebe os dados e retorna o valor correto, já validado conforme o objeto validate...
  Stream<String> get outEmail =>
      emailController.stream.transform(validateEmail);
  Stream<String> get outPassword =>
      passwordController.stream.transform(validatePassword);

  @override
  void dispose() {
    emailController.close();
    passwordController.close();
  }
}

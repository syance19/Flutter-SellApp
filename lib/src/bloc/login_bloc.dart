



import 'dart:async';

import 'package:formvalidation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

   //RECUPERAR DATOS STRING
   Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
   Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
   
   Stream <bool> get formValidStream => 
     Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);
  // INSERTAR VALORES AL STREAM
  Function(String) get changeEmail=> _emailController.sink.add;
  Function(String) get changePassword=> _passwordController.sink.add;
 //ULTIMO VALOR EN STREM
 String get email=> _emailController.value;
 String get passwod=> _passwordController.value;
  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}
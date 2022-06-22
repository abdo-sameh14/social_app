abstract class RegisterScreenStates {}

class RegisterScreenInitialState extends RegisterScreenStates {}

class RegisterScreenLoadingState extends RegisterScreenStates {}

class RegisterScreenSuccessState extends RegisterScreenStates {}

class RegisterScreenErrorState extends RegisterScreenStates {

  String error;
  RegisterScreenErrorState(this.error);
}

class RegisterScreenCreateUserSuccessState extends RegisterScreenStates {}

class RegisterScreenCreateUserErrorState extends RegisterScreenStates {

  String error;
  RegisterScreenCreateUserErrorState(this.error);
}

class RegisterScreenChangePasswordVisibility extends RegisterScreenStates{}
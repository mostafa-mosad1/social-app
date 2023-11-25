

class registerStates{}

class InitialStates extends registerStates{}

class LoadingRegister extends registerStates{}
class ScuessRegister extends registerStates{}
class ErrorRegister extends registerStates{
  String error;
  ErrorRegister(this.error,);
}


class LoadingCreateUser extends registerStates{}
class ScuessCreateUser extends registerStates{}
class ErrorCreateUser extends registerStates{
  String error;
  ErrorCreateUser(this.error,);
}
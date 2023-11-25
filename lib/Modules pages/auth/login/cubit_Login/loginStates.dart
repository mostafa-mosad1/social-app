

class logInStates{}

class InitialStates extends logInStates{}

class LoadinglogIn extends logInStates{}
class ScuesslogIn extends logInStates{}
class ErroelogIns extends logInStates{
  String error;

  ErroelogIns(this.error,);
}


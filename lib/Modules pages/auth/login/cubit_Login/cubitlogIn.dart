import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Shared/Network/Local/ShareReference/ShareReference.dart';
import 'loginStates.dart';


class logInCubit extends Cubit<logInStates> {
  logInCubit() : super(InitialStates());

  static logInCubit get(context) => BlocProvider.of(context);


var x= CachHelper.getData(key: "uid");

void logIN({required String email,required String password}){
  emit(LoadinglogIn());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.toString(),
      password: password.toString()).then((value) {
     print(value.user?.email);
     CachHelper.saveData(key: "uid", value: value.user?.uid);
     print("user id is =>> ${CachHelper.getData(key: "uid")}");
      emit(ScuesslogIn());
  }).catchError((error){
    print(error.toString());
    emit(ErroelogIns(error.toString()));
  });
}

}

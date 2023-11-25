import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sociall_app/Models/createUserModel.dart';
import 'package:sociall_app/Modules%20pages/auth/register/cubit_Register/statesRegister.dart';



class registerCubit extends Cubit<registerStates> {
  registerCubit() : super(InitialStates());

  static registerCubit get(context) => BlocProvider.of(context);


  void getRegisterData({
    String ?email,
    String ?password,
    String ?name,
    String ?phone,
    String ?image,
  }){
    emit(LoadingRegister());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.toString(),
        password: password.toString()).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      createUser(
        uid: value.user?.uid,
        email: email,
        phone: phone,
        image: image,
        name: name,

      );

    }).catchError((error){
      print(error.toString());
      emit(ErrorRegister(error.toString()));
    });
  }

  void createUser({
    String ?uid,
    String ?email,
    String ?phone,
    String ?image,
    String? cover,
    String? name,
    String? bio,
}){
    emit(LoadingCreateUser());
    CreateUserModel model = CreateUserModel(
      uid:uid,
      name : name,
      email : email, 
      phone: phone,
      // img:"https://img.freepik.com/free-photo/smiley-handsome-man-posing_23-2148911841.jpg?w=740&t=st=1695917384~exp=1695917984~hmac=f2e91be327208f960c255a50086e5a25bfc368f32ae8637ca3c247dcbe8c187d",
      // cover: "https://img.freepik.com/free-photo/smiley-handsome-man-posing_23-2148911841.jpg?w=740&t=st=1695917384~exp=1695917984~hmac=f2e91be327208f960c255a50086e5a25bfc368f32ae8637ca3c247dcbe8c187d",
      bio: "write you a bio",

    );
    FirebaseFirestore.instance.collection("user")
        .doc(uid)
        .set(model.toMap()).then((value) {
          print(model);
          emit(ScuessRegister());
          emit(ScuessCreateUser());
    }).catchError((error){
      print(error.toString());
      emit(ErrorCreateUser(error));
    });
  }
}

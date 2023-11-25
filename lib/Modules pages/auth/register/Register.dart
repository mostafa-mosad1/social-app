import 'dart:ui';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:sociall_app/Modules%20pages/auth/register/cubit_Register/cubitRegister.dart';
import 'package:sociall_app/Modules%20pages/auth/register/cubit_Register/statesRegister.dart';
import 'package:sociall_app/Shared/Components/components.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController imageController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    late RiveAnimationController _btnAnimationController;

    bool isShowSignInDialog = false;

    @override
    void initState() {
      _btnAnimationController = OneShotAnimation(
        "active",
        autoplay: false,
      );
      super.initState();
    }

    return BlocProvider(
      create: (context) => registerCubit(),
      child: BlocConsumer<registerCubit,registerStates>(
        listener: (context, state) {
          if(state is ScuessRegister){
            showToast(text: "تم انشاء الحساب بالنجاح",stutes:toastStutes.suess );
          }
          if(state is ErrorRegister){
            print("خطا في تسجيل الدخول");
            showToast(text: "خطا في تسجيل الدخول",stutes:toastStutes.error );
            showToast(text:state.error,stutes: toastStutes.error);
          }
        },
        builder: (context, state) =>Material(
          child: Stack(
            children: [
              Stack(
                children: [
                  Positioned(
                    width: MediaQuery.of(context).size.width * 1.7,
                    left: 100,
                    bottom: 100,
                    child: Image.asset(
                      "assets/Backgrounds/Spline.png",
                    ),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: const SizedBox(),
                    ),
                  ),
                  const RiveAnimation.asset(
                    "assets/RiveAssets/shapes.riv",
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: const SizedBox(),
                    ),
                  ),
                  AnimatedPositioned(
                    top: isShowSignInDialog ? -50 : 0,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    duration: const Duration(milliseconds: 260),
                    child: Text(''),
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("Register",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: Colors.blue),),
                      SizedBox(
                        height: 25,
                      ),
                      CustomerTextForm(
                        controller: nameController,
                        validatorPostion: true,
                        Textvalidator: "please enter name",
                        hintText: "please enter name",
                        labelText: "please enter name",
                        prefixIcon: Icon(Icons.email_outlined),
                        circular: 10),
                    SizedBox(
                      height: 20,
                    ),
                      CustomerTextForm(
                        controller: phoneController,
                        validatorPostion: true,
                        Textvalidator: "please enter phone",
                        hintText: "please enter phone",
                        labelText: "please enter phone",
                        prefixIcon: Icon(Icons.email_outlined),
                        circular: 10),
                    SizedBox(
                      height: 20,
                    ),
                      CustomerTextForm(
                        controller: emailController,
                        validatorPostion: true,
                        Textvalidator: "please enter email",
                        hintText: "please enter email",
                        labelText: "please enter email",
                        prefixIcon: Icon(Icons.email_outlined),
                        circular: 10),
                    SizedBox(
                      height: 20,
                    ),
                      CustomerTextForm(
                        controller: passwordController,
                        validatorPostion: true,
                        Textvalidator: "please enter password",
                        hintText: "please enter password",
                        labelText: "please enter password",
                        prefixIcon: Icon(Icons.email_outlined),
                        circular: 10),
                    SizedBox(
                      height: 20,
                    ),
                      CustomerTextForm(
                        controller: imageController,
                        validatorPostion: false,
                        Textvalidator: "please enter image",
                        hintText: "please enter image",
                        labelText: "please enter image",
                        prefixIcon: Icon(Icons.email_outlined),
                        circular: 10),
                    SizedBox(
                      height: 20,
                    ),
                      ConditionalBuilderRec(
                        condition: state is! LoadingRegister ,
                        builder: (context) => CustomerButton(
                            text: "Register",
                            textColor: Colors.white,
                            onPressed: (){
                              if(formKey.currentState!.validate())
                              {
                                registerCubit.get(context).getRegisterData(
                                  name:nameController.text ,
                                  phone: phoneController.text ,
                                  email:emailController.text ,
                                  password: passwordController.text,
                                  image: imageController.text,
                                );

                              }
                            }),
                        fallback:(context) => CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        ),
                      ),



                  ],),
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}

import 'dart:ui';

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../../Layout/social_layout.dart';
import '../../../Shared/Components/components.dart';
import '../register/Register.dart';
import 'cubit_Login/cubitlogIn.dart';
import 'cubit_Login/loginStates.dart';


class logIn extends StatefulWidget {
   logIn({Key? key}) : super(key: key);

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
        create: (context) => logInCubit(),
    child:BlocConsumer<logInCubit,logInStates>(
    listener: (context, state) {
      if(state is ScuesslogIn){
       navigateAndFinish(context,page: social_layout());

        showToast(text: "تم تسجيل الدخول بالنجاح",stutes:toastStutes.suess );
      }
      if(state is ErroelogIns){
        print("خطا في تسجيل الدخول");
        showToast(text: "خطا في تسجيل الدخول",stutes:toastStutes.error );
        showToast(text:state.error,stutes: toastStutes.error);
      }

    },
    builder: (context, state) => SafeArea(
      child: Scaffold(

        body: Center(
          child: SingleChildScrollView(
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
                  padding:  EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOG_IN",
                            style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: Colors.blue)),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "login now to browse your hot social app",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.grey),
                        ),
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
                            prefixIcon: Icon(Icons.lock_open_outlined),
                            validatorPostion: true,
                            Textvalidator: "please sure your password",
                            labelText: " enter password",
                            lock: true,
                            suffixIcon: Icon(Icons.remove_red_eye),
                            hintText: " enter password",
                            circular: 10),
                        SizedBox(
                          height: 15,
                        ), ConditionalBuilderRec(
                          condition: state is! LoadinglogIn ,
                          builder: (context) =>CustomerButton(
                              text: "LOG_IN",
                              textColor: Colors.white,
                              onPressed: (){
                                if(formKey.currentState!.validate())
                                {
                                  logInCubit.get(context).logIN(
                                      email:emailController.text,
                                      password:passwordController.text);
                                  //socialCubit.get(context).getProfileData();
                                }
                              }),
                          fallback:(context) => CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          ),
                        ),

                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",style:TextStyle(fontSize: 16)),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => Register(),));
                              },
                              child: Text("register now".toUpperCase(),
                                  style:TextStyle(color: Colors.blue,fontSize: 20) ),
                            ),
                          ],
                        ),
                      ],
                    ),),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    ),);
  }
}

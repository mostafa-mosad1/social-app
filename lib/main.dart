import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sociall_app/Modules%20pages/auth/login/login.dart';
import 'package:sociall_app/firebase_options.dart';
import 'Layout/cubit/socialCubit.dart';
import 'Layout/social_layout.dart';
import 'Shared/Network/Local/ShareReference/ShareReference.dart';
import 'Shared/Network/Remote/dio_helper.dart';
import 'Shared/bloc_observer.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform
 );

  Bloc.observer = MyBlocObserver();
  DioHelper.inital();
  await CachHelper.initial();


 print(userId);
 Widget widget;
  if(userId != null){
    widget =  social_layout();
  }else{
    widget = logIn();
  }
  runApp( MyApp(startingWidget: widget,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.startingWidget,this.mode});
   Widget startingWidget;bool? mode;


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => socialCubit()..getProfileData()..getPostData()..getAllUsers()..getChat())
      ],
      child: ScreenUtilInit(
        designSize:  Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          home: startingWidget ,

            themeMode: ThemeMode.light,
                //:ThemeMode.dark,
            theme: ThemeData(
                textTheme:TextTheme(
                    bodyMedium: TextStyle(color: Colors.black,fontSize: 25,)
                ),

                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                    titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),
                    iconTheme:IconThemeData(size: 35,color: Colors.black),
                    elevation: 0,//toolbarHeight: 50,
                   // shape: OutlineInputBorder(borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20)))
                ),

                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.shifting,
                    selectedItemColor: Colors.blue,
                   unselectedItemColor: Colors.grey
                )
            ),

            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor("333739"),
              iconTheme: IconThemeData(color: Colors.white),
              textTheme:TextTheme(
                  bodyMedium: TextStyle(color: Colors.white,fontSize: 25,)
              ),
              appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black26,
                      statusBarIconBrightness: Brightness.light
                  ),
                  titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),
                  iconTheme:IconThemeData(size: 35,color: Colors.white),
                  backgroundColor: HexColor("333739"),
                  elevation: 30,
              ),

              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.shifting,
                backgroundColor: HexColor("333739"),
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,

              ),

            )
        ),
      ),
    );
  }
}
String? userId = CachHelper.getData(key: "uid");




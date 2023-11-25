import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Modules pages/auth/login/login.dart';
import '../Modules pages/post/post.dart';
import '../Shared/Components/components.dart';
import '../Shared/Network/Local/ShareReference/ShareReference.dart';
import '../Shared/Styles/icons_borken.dart';
import 'cubit/socialCubit.dart';
import 'cubit/socialState.dart';

class social_layout extends StatelessWidget {
  const social_layout({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = socialCubit.get(context);
    return BlocConsumer<socialCubit,socialState>(
      listener: (context, state) {
        if(state is newPostState){
          navigatePush(context,page:post() );
        }
      },
      builder: (context, state) => SafeArea(child: Scaffold(
        appBar: AppBar(
          title: Text(cubit.title[cubit.currentIndex],
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 30,fontWeight: FontWeight.bold,)),
          actions: [
            IconButton(onPressed: (){
              CachHelper.removeData(key: "uid");
              navigateAndFinish(context,page: logIn());
            }, icon: Icon(IconBroken.Search,size: 30,)),
            IconButton(onPressed: (){}, icon:  Icon(IconBroken.Notification,size: 30)),
          ],
        ),
         body:cubit.pages[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,

          onTap: (index){
            cubit.changeBottonNav(index);
            print(cubit.currentIndex);
          },

          items: [
            BottomNavigationBarItem(
                icon:Icon(IconBroken.Home),
                label: "home"),
            BottomNavigationBarItem(
                icon:Icon(IconBroken.Chat),
                label: "chat"),
            BottomNavigationBarItem(
                icon:Icon(IconBroken.User),
                label: "User"),
            BottomNavigationBarItem(
                icon:Icon(IconBroken.Profile),
                label: "Profile"),

          ],
        ),
      )),
    );
  }
}

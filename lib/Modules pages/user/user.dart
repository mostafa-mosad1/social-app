import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sociall_app/Layout/cubit/socialCubit.dart';
import 'package:sociall_app/Layout/cubit/socialState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Shared/Styles/icons_borken.dart';

class user extends StatelessWidget {
  const user({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = socialCubit.get(context);
    return BlocConsumer<socialCubit,socialState>(
        listener: (context, state) {},
      builder: (context, state) => SafeArea(child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ListView.builder(
            shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>  Container(
                width: 350.w,
                padding: EdgeInsets.all( 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: NetworkImage(
                          "${cubit.Users[index].img}"
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "${cubit.Users[index].name}",
                      style: TextStyle(
                          height: 1.2.sp,
                          fontFamily: "Poppins",
                          // fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 22,
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          print("Add_User");
                        },
                        icon: Icon(
                          IconBroken.Add_User,
                          size: 28,
                        ))
                  ],
                ),
              ),

              itemCount: cubit.Users.length),
        ),
      )));
  }
}

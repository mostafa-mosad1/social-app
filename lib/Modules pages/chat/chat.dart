import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sociall_app/Layout/cubit/socialCubit.dart';
import 'package:sociall_app/Layout/cubit/socialState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociall_app/Modules%20pages/chat/chat_detailes.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:sociall_app/Shared/Components/components.dart';

class chat extends StatelessWidget {
  const chat({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = socialCubit.get(context);
    return BlocConsumer<socialCubit, socialState>(
        listener: (context, state) {},
        builder: (context, state) => SafeArea(
                child: Scaffold(
                    body: ConditionalBuilderRec(
                        condition:
                            State is !LoadingAllUsers ,
                        builder: (context) => SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      navigatePush(context,
                                          page: chat_detailes(
                                            model: cubit.Users[index],
                                          ));
                                    },
                                    child: Container(
                                      width: 350.w,
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            maxRadius: 40,
                                            backgroundImage:
                                                NetworkImage("${cubit.Users[index].img}"),
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
                                        ],
                                      ),
                                    ),
                                  ),
                              itemCount: cubit.Users.length),
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
            ))));
  }
}

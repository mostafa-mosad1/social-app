import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociall_app/Layout/cubit/socialCubit.dart';
import 'package:sociall_app/Layout/cubit/socialState.dart';
import 'package:sociall_app/Modules%20pages/edit_profile/edit_profile.dart';
import 'package:sociall_app/Shared/Components/components.dart';
import 'package:sociall_app/Shared/Styles/icons_borken.dart';

class setting extends StatelessWidget {
  const setting({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = socialCubit.get(context).userModel;
    return BlocConsumer<socialCubit, socialState>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilderRec(condition: "true"=="true",
          builder: (context) => SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage("${cubit?.cover}"))),

                    ),
                    Container(
                      margin: EdgeInsets.only(top: 170.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 104,
                              backgroundColor: Colors.blue,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage("${cubit?.img}"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "${cubit?.name} ",
                            maxLines: 1,
                            style: TextStyle(
                                height: 1.2.sp,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "${cubit?.bio}",
                                maxLines: 2,
                                style: TextStyle(fontSize: 20.sp,color: Colors.grey,),
                              )),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "30",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Text("Posts",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "1201",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Text("Followers",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "1024",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Text("Following",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: defaultButton(
                                        text: "Add photos",
                                        textStyle: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        function: () {},
                                        radius: 4,
                                        background: Colors.white,
                                        widthBorder: 1,
                                        colorBorder: Colors.black)),
                                SizedBox(width: 10.w),
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black)),
                                    child: IconButton(
                                        onPressed: () {
                                          print("edit");
                                          navigatePush(context,page: edit_profile());
                                        },
                                        icon: Icon(
                                          IconBroken.Edit,
                                          size: 30,
                                          color: Colors.blue,
                                        )))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      fallback: (context) => Center(child: CircularProgressIndicator()),)
    );
  }
}

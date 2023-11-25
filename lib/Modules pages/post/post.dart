import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sociall_app/Layout/cubit/socialCubit.dart';
import 'package:sociall_app/Layout/cubit/socialState.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Styles/icons_borken.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class post extends StatelessWidget {
  post({super.key});
  TextEditingController TextPost = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit =socialCubit.get(context);
   late File? PostImage = socialCubit.get(context).postImage;
    return BlocConsumer<socialCubit,socialState>(
      listener: (context, state) {},
      builder: (context, state) => SafeArea(
        child:Scaffold(
          appBar: defaultAppBar(
              context: context,
              text: "Create post",
              TextStyle: TextStyle(fontSize: 20, fontFamily: "Poppins"),
              action: [
                defaultButton(
                    text: "post",
                    textStyle: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    function: () {
                      DateTime now = DateTime.now();
                      if(cubit.postImage==null) {
                        cubit.CreatePostData(
                            date:now.toString(), text: TextPost.text);
                      }else
                      cubit.UploadPostImage(
                        date:now.toString(),
                        text: TextPost.text
                      );
                    },
                    isUpperCase: true,
                    width: 150,
                    background: Colors.white)
              ]),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(state is LoadingPostData)
                LinearProgressIndicator(
                  minHeight: 8,
                  color: Colors.red,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 40,
                    backgroundImage: NetworkImage(
                      "${cubit.userModel?.img}"
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${cubit.userModel?.name}",
                        style: TextStyle(
                            height: 1.2.sp,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp),
                      ),
                      Text("public ",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h,),
              Expanded(
                child: CustomerTextForm1(
                  controller: TextPost,hintText:  "what\'s on you mind ?",),
              ),
               if(state is pickedImagePostSuccess)
               Container(
                 alignment: Alignment.topRight,
                 width: double.infinity,height: 250,
                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image:  FileImage(PostImage!),fit:BoxFit.cover,
                     )
                   ),
                   child: CircleAvatar(
                     radius: 20,
                     backgroundColor: Colors.blue,
                     child: IconButton(onPressed: (){
                       cubit.removepostImage();
                     }, icon: Icon(Icons.close,size: 25,color: Colors.red,)),
                   )),
              Row(
                children: [
                  defaultTextIconButton(
                      onPressed:(){
                        cubit.getPostImage();
                      },
                      widthContainer: 180.w,
                      heightContainer: 60,
                      background:Colors.white,
                      Icon: Icon(IconBroken.Image),
                      text: "add photo".toUpperCase(),
                      TextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                  ),

                  CustomerButton(text: "# tags",
                    widthContainer: 180.w,
                    colorContainer: Colors.white,
                    heightContainer: 60,
                    textColor:  Colors.blue,
                    onPressed: (){},

                  ),
                ],)
            ],),

        ),
      ),
    );
  }
}



import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociall_app/Layout/cubit/socialCubit.dart';
import 'package:sociall_app/Layout/cubit/socialState.dart';
import 'package:sociall_app/Shared/Styles/ConstantStyle.dart';
import 'package:sociall_app/Shared/Styles/icons_borken.dart';

import '../../Models/createPostModel.dart';
import '../../Shared/Components/components.dart';
import '../post/comment.dart';
import '../post/post.dart';


class home extends StatelessWidget {
   home({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit =socialCubit.get(context);
    return BlocConsumer<socialCubit,socialState>(
       listener: (context, state) {},
      builder: (context, state) => ConditionalBuilderRec(
            condition:cubit.userModel != null  ,
            builder:(context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: (){
                      navigatePush(context,page:post(),);
                    },
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            maxRadius: 20,
                            backgroundImage: NetworkImage(
                                "${cubit.userModel?.img}"
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            "what\'s on you mind?",
                            style: TextIcon,
                          ),
                          Spacer(),
                          Icon(
                            IconBroken.Image,
                            size: 28,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                      height: 125,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildStoryItems(),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 15,
                          ),
                          itemCount: 7)),
                  SizedBox(
                    height: 10.h,
                  ),
                  ConditionalBuilderRec(condition: cubit.posts.length >0 && socialCubit.get(context).likesPost != null,
                      builder: (context) => ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => postScreen(context,socialCubit.get(context).posts[index],index),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8.h,
                        ),
                        itemCount: socialCubit.get(context).posts.length,
                      ),
                  fallback: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: Text("No_posts",
                        style: TextStyle(color: Colors.red,fontSize: 25),)),
                      SizedBox(width: 15.w,),
                      CircularProgressIndicator()
                    ],
                  ),),
                ],
              ),
            ),
            fallback:(context) => Center(child: CircularProgressIndicator()) ,
          )
    );
  }
}

Widget postScreen(context,CreatePostModel posts,index)=> Card(
  color: Colors.white,
  elevation: 30,
  child: Container(
    padding: EdgeInsets.all(8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 40,
              backgroundImage: NetworkImage(
                "${posts.img}"
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${posts.name}",
                      style: TextStyle(
                          // height: 1.2.sp,
                        fontFamily: "Poppins",
                          // fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 22,
                    )
                  ],
                ),
                Text("${posts.date}",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16)),
              ],
            ),
            Spacer(),
            IconButton(
                onPressed: () {
                  print("edit");
                },
                icon: Icon(
                  IconBroken.More_Square,
                  size: 28,
                ))
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 15.w, right: 15.w),
          height: 1.h,
          color: Colors.grey[400],
          width: double.infinity,
        ),
        SizedBox(
          height: 7.h,
        ),
        Text(
          "${posts.text}",
          maxLines: 4,
          style: TextStyle(
              height: 1.4.h,
              fontWeight: FontWeight.normal,
              fontSize: 18.sp,
              fontFamily: "Intel"),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Wrap(
            children: [
              Container(
                height: 25.h,
                padding: EdgeInsetsDirectional.only(end: 8),
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 10.w,
                  padding: EdgeInsets.zero,
                  child: Text(
                    "## Treand",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
              Container(
                height: 25.h,
                padding: EdgeInsetsDirectional.only(end: 8),
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 10.w,
                  padding: EdgeInsets.zero,
                  child: Text(
                    "## Treand",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),
                ),
              ),
              Container(
                height: 25,
                padding: EdgeInsetsDirectional.only(end: 8),
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 10,
                  padding: EdgeInsets.zero,
                  child: Text(
                    "## Treand",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
              Container(
                height: 25,
                padding: EdgeInsetsDirectional.only(end: 8),
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: 10,
                  padding: EdgeInsets.zero,
                  child: Text(
                    "## Treand",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        if(posts.imgPost != "")
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    offset: Offset(10, 10),
                    blurRadius: 20,
                    spreadRadius: 10)
              ]),
          child: Card(
            elevation: 20,
            child: Image(
                width: double.infinity,
                height: 140.h,
                fit: BoxFit.fill,
                image: NetworkImage(
                    "${posts.imgPost}"
                )),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    IconBroken.Heart,
                    color: Colors.red,
                  ),
                  label: Text(
                    "${socialCubit.get(context).likesPost[index]}",
                    style: TextIcon,
                  )),
              Spacer(),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    IconBroken.Chat,
                    color: Colors.amber,
                  ),
                  label: Text("${socialCubit.get(context).numberComment[index]}", style: TextIcon)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15.w, right: 15.w),
          height: 1,
          color: Colors.grey[400],
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    var PostId =socialCubit.get(context).postId[index];
                    print(PostId);
                    socialCubit.get(context).commentsUsers=[];

                    socialCubit.get(context).getComments(postid: PostId);
                   Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => comment(PostId:PostId),));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 20,
                        backgroundImage: NetworkImage(
                          "${socialCubit.get(context).userModel?.img}"
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        "write a comment ...",
                        style: TextIcon,
                      ),
                    ],
                  ),
                ),
              ),
              TextButton.icon(
                  onPressed: () {
                   socialCubit.get(context).love?{
                   socialCubit.get(context).likePost(postId: socialCubit.get(context).postId[index]),
                     socialCubit.get(context).likesPost=[],
                   socialCubit.get(context).getPostData(),
                   socialCubit.get(context).loveIcon(),
                   }:{
                     socialCubit.get(context).RemovelikePost(postId: socialCubit.get(context).postId[index]),
                     socialCubit.get(context).likesPost=[],
                     socialCubit.get(context).getPostData(),
                     socialCubit.get(context).loveIcon(),
                   };
                  },
                  icon: socialCubit.get(context).love?Icon(
                    IconBroken.Heart,
                    color: Colors.red,
                  ):Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  label: Text("${socialCubit.get(context).likesPost[index]}")),
              TextButton.icon(
                  onPressed: () {
                  },
                  icon: Icon(
                    Icons.share,
                    color: Colors.blue,
                  ),
                  label: Text(
                    "20",
                    style: TextIcon,
                  )),
            ],
          ),
        ),
      ],
    ),
  ),
);


Widget buildStoryItems() => Container(
  width: 60,
  child: Column(
    children: [
      Stack(alignment: Alignment.bottomRight, children: [
        CircleAvatar(
            radius: 30.0, backgroundImage: NetworkImage("https://img.freepik.com/free-photo/smiley-handsome-man-posing_23-2148911841.jpg?w=740&t=st=1695917384~exp=1695917984~hmac=f2e91be327208f960c255a50086e5a25bfc368f32ae8637ca3c247dcbe8c187d",)),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 9,
        ),
        CircleAvatar(
          backgroundColor: Colors.green,
          radius: 8,
        ),
      ]),
      Text(
        "mostafa mosad el tonbary",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      )
    ],
  ),
);
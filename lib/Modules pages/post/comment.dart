import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sociall_app/Layout/cubit/socialCubit.dart';
import 'package:sociall_app/Layout/cubit/socialState.dart';
import 'package:sociall_app/Shared/Components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';

import 'package:sociall_app/Shared/Styles/icons_borken.dart';



class comment extends StatelessWidget {
  var PostId;
   comment({super.key,this.PostId});
TextEditingController commentText = TextEditingController();
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var cubit = socialCubit.get(context);
    var commentData = socialCubit.get(context).commentsUsers;
   late var imageCommment = socialCubit.get(context).commentImage;
   var keyForm= GlobalKey<FormState>();
    return BlocConsumer<socialCubit,socialState>(
      listener: (context, state) {},
      builder: (context, state) => SafeArea(child: Scaffold(
          appBar: defaultAppBar(
            context:context ,
            text: "Comments",
            TextStyle: TextStyle(fontSize: 20, fontFamily: "Poppins"),
          ),
          body: ConditionalBuilderRec(
            condition: cubit.commentsUsers!=null,
            builder: (context) =>SingleChildScrollView(
            child: Form(
              key: keyForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            maxRadius: 20,
                            backgroundImage: NetworkImage(
                                "${socialCubit.get(context).userModel?.img}"
                            ),
                          ),
                          SizedBox(width: 8.w,),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric( horizontal: 8),
                                width: 295.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[400],),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${socialCubit.get(context).userModel?.name}",
                                      maxLines: 1,
                                      style: TextStyle(

                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp),
                                    ),
                                    if(commentData[index].text !="")
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      "${commentData[index].text}",
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 20,color: Colors.white),
                                    ),

                                  ],
                                ),
                              ),
                              if(commentData[index].imgPost !="")
                                Container(
                                  margin:EdgeInsets.only(top: 5),
                                  alignment: Alignment.center,
                                  width: 200,height: 150,
                                    decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(image: NetworkImage("${commentData[index].imgPost}"),fit: BoxFit.cover,))
                                ),
                            ],
                          ),


                        ],
                      ),
                    ),
                    itemCount: cubit.commentsUsers.length,),
                  // Spacer(),
                  if(state is pickedImageCommentsSuccess)
                    Container(
                        alignment: Alignment.topRight,
                        width: double.infinity,height: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image:  FileImage(imageCommment!),fit:BoxFit.cover,
                            )
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                          child: IconButton(onPressed: (){
                            cubit.removeCommentImage();
                          }, icon: Icon(Icons.close,size: 25,color: Colors.red,)),
                        )),
                  Container(
                    width: 400,
                    child: Row(children: [
                      IconButton(onPressed: (){
                        cubit.commentsImage();
                      }, icon: Icon(IconBroken.Camera)),
                      SizedBox(width: 10.w,),
                      Expanded(
                        child: CustomerTextForm1(
                          hintText: "write a comment",
                          controller:commentText,
                          keyboardType: TextInputType.text,
                          validatorPostion: true,
                          Textvalidator: "write a comment"
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      IconButton(onPressed: (){
                        // if(keyForm.currentState!.validate()){
                         if(imageCommment==null)
                         {
                           cubit.UploadCommentPost(
                               postId: PostId,
                               text: commentText.text,
                               date:now.toString() );
                         }else
                         {
                           cubit.UploadCommentImage(
                               text: commentText.text,
                               postId: PostId,
                               date: now.toString()
                           );
                         }
                       //}

                        // if(state is SuccessLoadingUploadCommentPost || state is upLoadImageCommentsSuccess){
                        //   print(commentText.toString());
                        //   socialCubit.get(context).commentsUsers=[];
                        //   socialCubit.get(context).getComments(postid:PostId);
                        // }

                      }, icon: Icon(IconBroken.Send,color: Colors.green,size: 25,)),
                    ],),
                  ),
                ],),
            ),
          ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        )),

      )
    );
  }
}

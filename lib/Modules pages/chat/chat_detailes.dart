import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sociall_app/Layout/cubit/socialCubit.dart';
import 'package:sociall_app/Layout/cubit/socialState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociall_app/Shared/Styles/icons_borken.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';


import '../../Models/messageModel.dart';
import '../../Shared/Components/components.dart';


class chat_detailes extends StatelessWidget {
  var model;
   chat_detailes({super.key,this.model});

  @override
  Widget build(BuildContext context) {
    TextEditingController textChat = TextEditingController();
    var cubit = socialCubit.get(context);
    var message = socialCubit.get(context).messages;
    late int count =cubit.messages.length;
    return Builder(
      builder: (context) {
        cubit.getChat(receiverId: "${model.uid}");
        return BlocConsumer<socialCubit,socialState>(
          listener: (context, state) {},
          builder: (context, state) =>SafeArea(child: Scaffold(
              appBar: AppBar(
                  leading: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(IconBroken.Arrow___Left_2),),
                  title:Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(children: [
                      CircleAvatar(
                        maxRadius: 30,
                        backgroundImage: NetworkImage(
                            "${model.img}"
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "${model.name}",
                        style: TextStyle(
                            height: 1.2.sp,
                            fontFamily: "Poppins",
                            // fontWeight: FontWeight.bold,
                            fontSize: 20.sp),
                      ),
                    ],),
                  )

              ),
              body: ConditionalBuilderRec(
                condition:state is !GetChatLoading,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                  ConditionalBuilderRec(condition: cubit.messages.length>0&& cubit.messages!=null,
                      builder: (context) =>  Expanded(
                        child: ListView.separated(
                            // controller:
                            // cubit.scrollController,
                            // cacheExtent: socialCubit.get(context).itemsize,
                            itemBuilder: (context, index) {

                          var messade = cubit.messages[index].uid;
                          if(cubit.userModel?.uid==messade){

                            return
                            bliudMyMessage (message:message[index]);

                          }else{

                            return bliudMessage(message: cubit.messages[index]);
                          }
                        },
                            separatorBuilder: (context, index) => SizedBox(height: 10,),
                            itemCount:count),
                      ),
                      fallback: (context) => Expanded(child: Center(child:CircularProgressIndicator() )),
                  ),
                    if(state is pickedImageChatSuccess)
                      Container(
                          alignment: Alignment.topRight,
                          width: double.infinity,height: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image:  FileImage(cubit.chatImage!),fit:BoxFit.cover,
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:Border.all(width: 1,)
                      ),
                      width: 400,
                      child: Row(children: [
                        IconButton(onPressed: (){
                          cubit.chatsImage();
                        }, icon: Icon(IconBroken.Camera)),
                        SizedBox(width: 10.w,),
                        Expanded(
                          child: CustomerTextForm1(
                              hintText: "  Aa     ",
                              controller:textChat,
                              keyboardType: TextInputType.text,
                              validatorPostion: true,
                              Textvalidator: "write a comment"
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        IconButton(onPressed: (){
                          print(textChat.text);
                          cubit.chats(
                            receiverId:"${model.uid}",
                            text: textChat.text,
                            date: DateTime.now().toString(),
                          );
                        } , icon: Icon(IconBroken.Send,color: Colors.green,size: 25,)),
                      ],),
                    ),
                  ],),
                ),
                fallback:(context) =>  Center(child: CircularProgressIndicator()),
              )
          )),
        );
      },
    );
  }
}

Widget bliudMessage ({ required MessageModel message})=>Align(
  alignment: Alignment.topLeft,
  child: Container(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10),bottomRight:Radius.circular(10))
      ),
      child: Text("${message.text}")),
);

Widget bliudMyMessage({ MessageModel? message})=> Align(
  alignment: Alignment.topRight,
  child: Container(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft:Radius.circular(10),bottomLeft:Radius.circular(10))
      ),
      child: Text("${message?.text}")),
);

//    "${}"
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Layout/cubit/socialCubit.dart';
import '../../Layout/cubit/socialState.dart';
import '../../Shared/Components/components.dart';
import '../../Shared/Styles/icons_borken.dart';

class edit_profile extends StatelessWidget {
  const edit_profile({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = socialCubit.get(context).userModel;
  late File? coverImage = socialCubit.get(context).coverImage;
   late File? profileImage = socialCubit.get(context).ProfileImage;

    TextEditingController name = TextEditingController();
    TextEditingController bio = TextEditingController();
    TextEditingController phone = TextEditingController();

   name.text = cubit!.name.toString();
    bio.text = cubit!.bio.toString();
    phone.text = cubit!.phone.toString();

    return BlocConsumer<socialCubit, socialState>(
      listener: (context, state) {

          if(state is SuccessLoadingUpdateUserData || state is upLoadImageProfileSuccess||state is upLoadImageCoverSuccess ){
            showToast(text: "تم تحديث البيانات بالنجاح",stutes:toastStutes.suess );
          }
      },
      builder: (context, state) => SafeArea(
        child: Scaffold(
          appBar:
              defaultAppBar(text: "Edit profile", context: context, action: [
            CustomerButton(
                text: "Update",
                onPressed: () {
                  socialCubit.get(context).updateProfileData(
                      name:name.text,
                      bio: bio.text,
                      phone: phone.text,
                    img: profileImage?.path,
                    cover: coverImage?.path,
                  );
                },
                widthContainer: 130,
                colorContainer: Colors.white,
                textColor: Colors.blue),
            SizedBox(
              width: 10,
            )
          ]),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: [
                Container(
                        width: double.infinity,
                        height: 180.h,
                        child:
                        Stack(children: [
                         coverImage == null?
                        Image(image: NetworkImage("${cubit.cover}"),width: double.infinity,fit:BoxFit.cover,)
                            : Image.file(coverImage as File,width: double.infinity,fit:BoxFit.cover,),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                                radius: 25,
                                child: IconButton(
                                  onPressed: () {
                                    socialCubit.get(context).getCoverImage();
                                  },
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 34,
                                  ),
                                )),
                          )
                        ],)),


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
                            child: Stack(children: [
                              profileImage == null
                                  ? Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage("${cubit.img}"),
                                          fit: BoxFit.cover),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                                  )
                                  : CircleAvatar(
                                radius: 100,
                                backgroundImage: FileImage(profileImage),
                              ),

                              Container(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 25,
                                  child: IconButton(
                                    onPressed: () {
                                      socialCubit.get(context).getProfileImage();
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 34,
                                    ),
                                  ),
                                ),
                              )
                            ],),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      if(profileImage!=null||coverImage!=null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          if(profileImage!=null)

                                Container(
                                  width: 200,height: 60,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: defaultButton(
                                            function: (){
                                              socialCubit.get(context).UploadProfileImage(
                                                  name:name.text,
                                                  bio: bio.text,
                                                  phone: phone.text
                                              );
                                            },
                                            radius: 5,
                                            text: "upload Profile image",
                                            isUpperCase: true),
                                      ),
                                       SizedBox(height: 5,),
                                       if(state is upLoadImageProfileSuccess)
                                       LinearProgressIndicator()
                                    ],
                                  ),
                                ),


                          SizedBox(width: 5,),
                          if(coverImage!=null)
                              Container(
                                width: 200,height: 60,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: defaultButton(
                                          function: (){
                                            socialCubit.get(context).UploadCoverImage(
                                                name:name.text,
                                                bio: bio.text,
                                                phone: phone.text
                                            );
                                          },
                                          radius: 5,
                                          text: "upload cover image",
                                          isUpperCase: true),
                                    ),
                                    SizedBox(height: 5,),
                                    if(state is upLoadImageCoverSuccess)
                                    LinearProgressIndicator()
                                  ],
                                ),
                              ),

                            ],
                          ),


                      SizedBox(
                        height: 10.h,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [

                            SizedBox(height: 15.h,),
                            CustomerTextForm(
                              prefixIcon: Icon(Icons.person_3_outlined),
                              labelText: "name",
                              controller:name,

                            ),
                            SizedBox(height: 15.h,),
                            CustomerTextForm(
                              prefixIcon: Icon(IconBroken.Info_Circle),
                              labelText: "bio",
                              controller:bio ,
                            ),
                            SizedBox(height: 15.h,),
                            CustomerTextForm(
                                prefixIcon: Icon(IconBroken.Call),
                                labelText: "phone",
                                controller: phone,
                                keyboardType:TextInputType.phone
                            ),
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
    );
  }
}

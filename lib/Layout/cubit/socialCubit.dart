import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sociall_app/Layout/cubit/socialState.dart';
import 'package:sociall_app/Models/commentsModel.dart';
import 'package:sociall_app/Models/LikesDataModel.dart';
import 'package:sociall_app/Models/createPostModel.dart';
import '../../Models/createUserModel.dart';
import '../../Models/messageModel.dart';
import '../../Modules pages/chat/chat.dart';
import '../../Modules pages/home/home.dart';
import '../../Modules pages/setting/setting.dart';
import '../../Modules pages/user/user.dart';
import '../../Shared/Network/Local/ShareReference/ShareReference.dart';

class socialCubit extends Cubit<socialState> {
  socialCubit() : super(initalState());

  static socialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> pages = [home(), chat(), user(), setting()];

  List<String> title = ["Home", "Chats", "Users", "Settings"];
  void changeBottonNav(int index) {
    // if(currentIndex == 1 ) {
    //   Users=[];
    //   getAllUsers();
    //   emit(pickedImageCoverSuccess());
    // }
    // if(currentIndex == 3 ) {
    //  userModel=null;
    //   getProfileData();
    //   emit(pickedImageCoverSuccess());
    // }
    currentIndex = index;
      emit(changeBotton());

  }

  // logic code of app

  CreateUserModel? userModel;
  void getProfileData() {
    emit(LoadingUserData());
    var id = CachHelper.getData(key: "uid");
    FirebaseFirestore.instance.collection("user").doc(id).get().then((value) {
      // print("data user is => ${value.data()}");
      userModel = CreateUserModel.formJson(value.data()!);
      // print("data user is => ${userModel?.name}");
      emit(SuccessLoadingUserData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLoadingUserData(error.toString()));
    });
  }

  File? coverImage;
  var picker = ImagePicker();

  Future<void> getCoverImage() async {
    final fileImage = await picker.pickImage(source: ImageSource.gallery);
    if (fileImage != null) {
      coverImage = File(fileImage.path);
      print("imagePath =>>> ${coverImage?.path}");
      emit(pickedImageCoverSuccess());
    } else {
      print("not picked image");
      emit(pickedImageCoverError());
    }
  }

  File? ProfileImage;

  Future<void> getProfileImage() async {
    var fileImage = await picker.pickImage(source: ImageSource.gallery);
    if (fileImage != null) {
      ProfileImage = File(fileImage.path);
      print("imagePath =>>>${ProfileImage?.path}");

      emit(pickedImageProfileSuccess());
    } else {
      print("not picked image");
      emit(pickedImageProfileError());
    }
  }

  void UploadCoverImage({
    String? bio,
    String? name,
    String? phone,
  }) {
    FirebaseStorage.instance
        .ref()
        .child("user/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateProfileData(cover: value, bio: bio, name: name, phone: phone);
        emit(upLoadImageCoverSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(upLoadImageCoverError());
      });
    }).catchError((error) {
      print(error.toString());
      emit(upLoadImageCoverError());
    });
  }

  void UploadProfileImage({
    String? bio,
    String? name,
    String? phone,
  }) {
    FirebaseStorage.instance
        .ref()
        .child("user/${Uri.file(ProfileImage!.path).pathSegments.last}")
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print("pathSegments =>>>  ${value}");
        updateProfileData(img: value, bio: bio, name: name, phone: phone);
        emit(upLoadImageProfileSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(upLoadImageProfileError());
      });
    }).catchError((error) {
      print(error.toString());
      emit(upLoadImageProfileError());
    });
  }

  void updateProfileData({
    String? uid,
    String? name,
    String? phone,
    String? email,
    String? bio,
    String? img,
    String? cover,
  }) {
    emit(LoadingUpdateUserData());

    CreateUserModel updateModel = CreateUserModel(
      uid: userModel?.uid,
      name: name,
      phone: phone,
      email: userModel?.email,
      cover: cover ?? userModel?.cover,
      bio: bio,
      img: img ?? userModel?.img,
    );
    FirebaseFirestore.instance
        .collection("user")
        .doc(userModel?.uid)
        .update(updateModel.toMap())
        .then((value) {
      getProfileData();
      emit(SuccessLoadingUpdateUserData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLoadingUpdateUserData(error.toString()));
    });
  }

/////////****************** home ***************************
  File? postImage;

  Future<void> getPostImage() async {
    var fileImage = await picker.pickImage(source: ImageSource.gallery);
    if (fileImage != null) {
      postImage = File(fileImage.path);
      print("imagePath =>>>${postImage?.path}");

      emit(pickedImagePostSuccess());
    } else {
      print("not picked image");
      emit(pickedImagePostError());
    }
  }

  void removepostImage() {
    postImage = null;
    emit(removPickedImagePostSuccess());
  }

  void UploadPostImage({
    String? text,
    String? date,
  }) {
    FirebaseStorage.instance
        .ref()
        .child("post/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print("pathSegments =>>>  ${value}");
        CreatePostData(date: date, text: text, imgPost: value);
        emit(upLoadImagePostSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(upLoadImagePostError());
      });
    }).catchError((error) {
      print(error.toString());
      emit(upLoadImagePostError());
    });
  }

  void CreatePostData({String? text, String? date, String? imgPost}) {
    emit(LoadingCreatePostData());
    CreatePostModel model = CreatePostModel(
        uid: userModel?.uid,
        name: userModel?.name,
        img: userModel?.img,
        text: text,
        date: date,
        imgPost: imgPost ?? "");
    FirebaseFirestore.instance
        .collection("post")
        .add(model.toMap())
        .then((value) {
      posts = [];
      getPostData();
      emit(SuccessLoadingCreatePostData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLoadingCreatePostData(error.toString()));
    });
  }

  List<CreatePostModel> posts = [];
  List likesPost = [];
  List likesPostData = [];
  List postId = []; //   هنا علشان احط postId جوه list

  void getPostData() {
    emit(LoadingPostData());
    FirebaseFirestore.instance.collection("post").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("comments").get().then((value) {
          numberComment.add(value.docs.length);
          // value.docs.forEach((element) {
          //   commentsUsers.add(CommentsModel.FormJson(element.data()));
          //   emit(SuccessLoadingCommentPost());
          // });

        }).catchError((error) {
          print("getCommmentError is =>>>>>>${error.toString()}");
          emit(ErrorLoadingCommentPost(error));
        });
        element.reference.collection("likes").get().then((value) {
          likesPost.add(value.docs.length);
          posts.add(CreatePostModel.FormJson(element.data()));
          postId.add(element.id);
          emit(SuccessLoadingLikePost());
        }).catchError((error) {
          print("likes error is =>>> ${error.toString()}");
          emit(ErrorLoadingLikePost(error));
        });
      });
      emit(SuccessLoadingPostData());
    }).catchError((error) {
      print("error posts =>>>>> ${error.toString()}");
      emit(ErrorLoadingPostData(error));
    });
  }

  /// likes home
  void likePost({String? postId}) {
    emit(LoadingLikePost());
    FirebaseFirestore.instance
        .collection("post")
        .doc(postId)
        .collection("likes")
        .doc(userModel?.uid)
        .set({"likes": true}).then((value) {
      emit(SuccessLoadingLikePost());
    }).catchError((error) {
      print("error posts =>>>>> ${error.toString()}");
      emit(ErrorLoadingLikePost(error));
    });
  }

  void RemovelikePost({String? postId}) {
    emit(RemoveLikesPost());
    FirebaseFirestore.instance
        .collection("post")
        .doc(postId)
        .collection("likes")
        .doc(userModel?.uid).
    delete().then((value) {
      emit(SuccessRemoveLikesPost());
    }).catchError((error) {
      print("RemoveLikesPost =>>>>> ${error.toString()}");
      emit(ErrorRemoveLikesPost(error));
    });
  }

  bool love = false;

  void loveIcon(){
    love=!love;
    emit( ChangeLikesPost() );
  }

  // List<LikesDataModel> likesDataModel = [];
  //
  // void getLikesData({String? postid}) {
  //   emit(LoadingLikesPost());
  //   FirebaseFirestore.instance
  //       .collection("post")
  //       .doc(postid)
  //       .collection("likes")
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       likesDataModel.add(LikesDataModel.FormJson(element.data()));
  //       emit(SuccessLoadingLikesPost());
  //     });
  //
  //   }).catchError((error) {
  //     print("getDataLikesError is =>>>>>>${error.toString()}");
  //     emit(ErrorLoadingLikesPost(error.toString()));
  //   });
  // }

  /// coments home
  File? commentImage;

  Future<void> commentsImage() async {
    var fileImage = await picker.pickImage(source: ImageSource.gallery);
    if (fileImage != null) {
      commentImage = File(fileImage.path);
      print("imagePath =>>>${commentImage?.path}");

      emit(pickedImageCommentsSuccess());
    } else {
      print("not picked image");
      emit(pickedImageCommentsError());
    }
  }

  void removeCommentImage() {
    postImage = null;
    emit(removPickedImageCommentSuccess());
  }

  void UploadCommentImage({String? postId, String? text,String? date}) {
    FirebaseStorage.instance
        .ref()
        .child("comment/${Uri.file(commentImage!.path).pathSegments.last}")
        .putFile(commentImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print("pathSegments =>>>  ${value}");
        UploadCommentPost(
            text: text,
            postId: postId,
            date:date,
          imgPost: value
        );
        emit((upLoadImageCommentsSuccess()));
      }).catchError((error) {
        print(error.toString());
        emit((upLoadImageCommentsError()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(upLoadImageCommentsError());
    });
  }

  void UploadCommentPost({String? postId, String? text,String? date,String? imgPost}) {
    CommentsModel model=CommentsModel(
      uid: userModel?.uid,
      name: userModel?.name,
      img: userModel?.img,
      text: text,
      imgPost:imgPost?? "",
      date: date
    );
    emit(LoadingUploadCommentPost());
    FirebaseFirestore.instance
        .collection("post")
        .doc(postId)
        .collection("comments")
        .doc(userModel?.uid)
        .set(model.toMap()).then((value) {
      emit(SuccessLoadingUploadCommentPost());
    }).catchError((error) {
      print("error posts =>>>>> ${error.toString()}");
      emit(ErrorLoadingUploadCommentPost(error));
    });
  }

List<CommentsModel> commentsUsers = [];
 List numberComment = [];
  void getComments({String? postid}) {
    emit(LoadingCommentPost());
    FirebaseFirestore.instance
        .collection("post")
        .doc(postid)
        .collection("comments")
        .get()
        .then((value) {
          print(value.docs.length);
          numberComment.add(value.docs.length);
      value.docs.forEach((element) {
        commentsUsers.add(CommentsModel.FormJson(element.data()));
        emit(SuccessLoadingCommentPost());
      });

    }).catchError((error) {
      print("getCommmentError is =>>>>>>${error.toString()}");
      emit(ErrorLoadingCommentPost(error));
    });
  }

  /// getAllUsers

  List<CreateUserModel> Users = [];

  void getAllUsers() {
    emit(LoadingAllUsers());
    FirebaseFirestore.instance
        .collection("user")
        .get()
        .then((value) {
          print(value);

      value.docs.forEach((element) {
        if(userModel?.uid != element.data() ["uid"])
        Users.add(CreateUserModel.formJson(element.data()));
      });
          emit(SuccessLoadingAllUsers());
    }).catchError((error) {
      print("UsersError is =>>>>>>${error.toString()}");
      emit(ErrorLoadingAllUsers(error));
    });
  }

  /// chat
List<MessageModel> messages=[];

  void chats({
   required String receiverId,
    receiverIdImage,date,text
}){
    MessageModel model = MessageModel(
      date: date,
      text: text,
      uid: userModel?.uid,
      receiverId: receiverId,
    );
    FirebaseFirestore.instance
        .collection("user")
        .doc(userModel?.uid)
        .collection("chat")
        .doc(receiverId)
        .collection("message")
        .add(model.toMap())
        .then((value) {
          emit(SuccessLoadingSendMessage());
    })
        .catchError((error){
          print("error message=>>>>${error.toString()}");
          emit(ErrorLoadingSendMessage(error));
    });


    FirebaseFirestore.instance
        .collection("user")
        .doc(receiverId)
        .collection("chat")
        .doc(userModel?.uid)
        .collection("message")
        .add(model.toMap())
        .then((value) {
      emit(SuccessLoadingSendMessage());
    })
        .catchError((error){
      print("error message=>>>>${error.toString()}");
      emit(ErrorLoadingSendMessage(error));
    });

  }


  void getChat({ String? receiverId,}) {
    emit(GetChatLoading());
    FirebaseFirestore.instance
        .collection("user")
        .doc(userModel?.uid)
        .collection("chat")
        .doc(receiverId)
        .collection("message")
        .orderBy("date")
        .snapshots()
        .listen((event) {
          messages=[];
          event.docs.forEach((element) {
            messages.add(MessageModel.FormJson(element.data()));
            // print("2222222=>>${messages[0].text}");
            // print("111111${element.data()}");
          });
          emit(SuccessGetChat());
    });
  }

  ScrollController scrollController = ScrollController();
  double itemsize = 100;

  getScroll() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 100);
    emit(SuccessScrollState());
  }
  File? chatImage;

  Future<void> chatsImage() async {
    var fileImage = await picker.pickImage(source: ImageSource.gallery);
    if (fileImage != null) {
      chatImage = File(fileImage.path);
      print("imagePath =>>>${chatImage?.path}");

      emit(pickedImageChatSuccess());
    } else {
      print("not picked image");
      emit(pickedImageChatsError());
    }
  }

  void removeChatImage() {
    postImage = null;
    emit(removPickedImageChatSuccess());
  }

  // void UploadCommentImage({String? postId, String? text,String? date}) {
  //   FirebaseStorage.instance
  //       .ref()
  //       .child("comment/${Uri.file(commentImage!.path).pathSegments.last}")
  //       .putFile(commentImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print("pathSegments =>>>  ${value}");
  //       UploadCommentPost(
  //           text: text,
  //           postId: postId,
  //           date:date,
  //           imgPost: value
  //       );
  //       emit((upLoadImageCommentsSuccess()));
  //     }).catchError((error) {
  //       print(error.toString());
  //       emit((upLoadImageCommentsError()));
  //     });
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(upLoadImageCommentsError());
  //   });
  // }

}

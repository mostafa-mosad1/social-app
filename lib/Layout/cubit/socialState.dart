abstract class socialState {}

class initalState extends socialState{}

class changeBotton extends socialState{}
class newPostState extends socialState{}

class darkState extends socialState{}

class LoadingUserData extends socialState{}
class SuccessLoadingUserData extends socialState{}
class ErrorLoadingUserData extends socialState{
  final String error;
  ErrorLoadingUserData(this.error);
}

class LoadingUpdateUserData extends socialState{}
class SuccessLoadingUpdateUserData extends socialState{}
class ErrorLoadingUpdateUserData extends socialState{
  final String error;
  ErrorLoadingUpdateUserData(this.error);
}


// to sellect form gellery

class pickedImageCoverSuccess extends socialState{}
class pickedImageCoverError extends socialState{}



// to uploadImage form gellery

class upLoadImageCoverSuccess extends socialState{}
class upLoadImageCoverError extends socialState{}

// to sellect form gellery

class pickedImageProfileSuccess extends socialState{}
class pickedImageProfileError extends socialState{}

// to uploadImage form gellery

class upLoadImageProfileSuccess extends socialState{}
class upLoadImageProfileError extends socialState{}


//////////****************** home ************************

// to sellect form gellery to post

class pickedImagePostSuccess extends socialState{}
class pickedImagePostError extends socialState{}

// to sellect form gellery to post

class removPickedImagePostSuccess extends socialState{}

// to uploadImage form gellery to post

class upLoadImagePostSuccess extends socialState{}
class upLoadImagePostError extends socialState{}

class LoadingCreatePostData extends socialState{}
class SuccessLoadingCreatePostData extends socialState{}
class ErrorLoadingCreatePostData extends socialState{
  final String error;
  ErrorLoadingCreatePostData(this.error);
}


class LoadingPostData extends socialState{}
class SuccessLoadingPostData extends socialState{}
class ErrorLoadingPostData extends socialState{
  final String error;
  ErrorLoadingPostData(this.error);
}
/// likes

class LoadingLikePost extends socialState{}
class SuccessLoadingLikePost extends socialState{}
class ErrorLoadingLikePost extends socialState{
  final String error;
  ErrorLoadingLikePost(this.error);
}


class RemoveLikesPost extends socialState{}
class SuccessRemoveLikesPost extends socialState{}
class ErrorRemoveLikesPost extends socialState{
  final String error;
  ErrorRemoveLikesPost(this.error);
}

class ChangeLikesPost extends socialState{}
/// comments


class pickedImageCommentsSuccess extends socialState{}
class pickedImageCommentsError extends socialState{}


// to uploadImage form gellery to post

class upLoadImageCommentsSuccess extends socialState{}
class upLoadImageCommentsError extends socialState{}

// to re move PickedImageComment
class removPickedImageCommentSuccess extends socialState{}


class LoadingCreateComments extends socialState{}
class SuccessLoadingComments extends socialState{}
class ErrorLoadingComments extends socialState{
  final String error;
  ErrorLoadingComments(this.error);
}



class LoadingUploadCommentPost extends socialState{}
class SuccessLoadingUploadCommentPost extends socialState{}
class ErrorLoadingUploadCommentPost extends socialState{
  final String error;
  ErrorLoadingUploadCommentPost(this.error);
}

class LoadingCommentPost extends socialState{}
class SuccessLoadingCommentPost extends socialState{}
class ErrorLoadingCommentPost extends socialState{
  final String error;
  ErrorLoadingCommentPost(this.error);
}


/// users

class LoadingAllUsers extends socialState{}
class SuccessLoadingAllUsers extends socialState{}
class ErrorLoadingAllUsers extends socialState{
  final String error;
  ErrorLoadingAllUsers(this.error);
}

/// chats

class LoadingSendMessage extends socialState{}
class SuccessLoadingSendMessage extends socialState{}
class ErrorLoadingSendMessage extends socialState{
  final String error;
  ErrorLoadingSendMessage(this.error);
}

// select image


class pickedImageChatSuccess extends socialState{}
class pickedImageChatsError extends socialState{}

// to uploadImage form gellery to post

class upLoadImageChatsSuccess extends socialState{}
class upLoadImageChatsError extends socialState{}

// to re move PickedImageComment
class removPickedImageChatSuccess extends socialState{}

// getChat
class GetChatLoading extends socialState{}
class SuccessGetChat extends socialState{}

class SuccessScrollState extends socialState{}
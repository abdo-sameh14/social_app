abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserDataLoadingState extends SocialStates{}

class SocialGetUserDataSuccessState extends SocialStates{}

class SocialGetUserDataErrorState extends SocialStates{

  final String error;
  SocialGetUserDataErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{

  final String error;
  SocialGetPostsErrorState(this.error);
}

class SocialGetUsersLoadingState extends SocialStates{}

class SocialGetUsersSuccessState extends SocialStates{}

class SocialGetUsersErrorState extends SocialStates{

  final String error;
  SocialGetUsersErrorState(this.error);
}

class SocialGetLikesLoadingState extends SocialStates{}

class SocialGetLikesSuccessState extends SocialStates{}

class SocialGetLikesErrorState extends SocialStates{

  final String error;
  SocialGetLikesErrorState(this.error);
}

class SocialGetCommentsLoadingState extends SocialStates{}

class SocialGetCommentsSuccessState extends SocialStates{}

class SocialGetCommentsErrorState extends SocialStates{

  final String error;
  SocialGetCommentsErrorState(this.error);
}

class SocialUpdateUserDataLoadingState extends SocialStates{}

class SocialUpdateUserDataSuccessState extends SocialStates{}

class SocialUpdateUserDataErrorState extends SocialStates{

  final String error;
  SocialUpdateUserDataErrorState(this.error);
}

class SocialPickedProfileImageSuccessState extends SocialStates{}

class SocialPickedProfileImageErrorState extends SocialStates{}

class SocialPickedCoverImageSuccessState extends SocialStates{}

class SocialPickedCoverImageErrorState extends SocialStates{}

class SocialPickedPostImageSuccessState extends SocialStates{}

class SocialPickedPostImageErrorState extends SocialStates{}

class SocialPickedChatImageSuccessState extends SocialStates{}

class SocialPickedChatImageErrorState extends SocialStates{}

class SocialUploadProfileImageLoadingState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageLoadingState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUploadPostImageLoadingState extends SocialStates{}

class SocialUploadPostImageSuccessState extends SocialStates{}

class SocialUploadPostImageErrorState extends SocialStates{}

class SocialAddNewPostLoadingState extends SocialStates{}

class SocialAddNewPostSuccessState extends SocialStates{}

class SocialAddNewPostErrorState extends SocialStates{}


class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{}

class SocialCommentPostSuccessState extends SocialStates{}

class SocialCommentPostErrorState extends SocialStates{}

class SocialChangePostLikeState extends SocialStates{}

class SocialRemovePostImage extends SocialStates{}

class SocialRemoveChatImage extends SocialStates{}

class SocialChangeBotNavBarState extends SocialStates{}

class SocialAddPostState extends SocialStates{}

class SocialSendMsgSuccessState extends SocialStates{}

class SocialSendMsgErrorState extends SocialStates{}

class SocialGetMsgsSuccessState extends SocialStates{}
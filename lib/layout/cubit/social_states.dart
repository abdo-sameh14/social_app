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

class SocialRemovePostImage extends SocialStates{}

class SocialChangeBotNavBarState extends SocialStates{}

class SocialAddPostState extends SocialStates{}

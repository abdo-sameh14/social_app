abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserDataLoadingState extends SocialStates{}

class SocialGetUserDataSuccessState extends SocialStates{}

class SocialGetUserDataErrorState extends SocialStates{

  final String error;
  SocialGetUserDataErrorState(this.error);
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

class SocialUploadProfileImageLoadingState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageLoadingState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialChangeBotNavBarState extends SocialStates{}

class SocialAddPostState extends SocialStates{}

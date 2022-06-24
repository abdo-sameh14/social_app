abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserDataLoadingState extends SocialStates{}

class SocialGetUserDataSuccessState extends SocialStates{}

class SocialGetUserDataErrorState extends SocialStates{

  final String error;
  SocialGetUserDataErrorState(this.error);
}

class SocialChangeBotNavBarState extends SocialStates{}

class SocialAddPostState extends SocialStates{}

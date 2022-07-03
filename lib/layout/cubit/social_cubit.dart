import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/chat_model/chat_model.dart';
import 'package:social_app/models/posts_model/post_model.dart';
import 'package:social_app/models/users_model/users_model.dart';
import 'package:social_app/modules/chats_screen/chat_screen.dart';
import 'package:social_app/modules/news_feed_screen/news_feed_screen.dart';
import 'package:social_app/modules/settings_screen/settings_screen.dart';
import 'package:social_app/modules/users_screen/users_screen.dart';

import '../../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UsersModel? userModel;


  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .get()
        .then((value) {
          userModel = UsersModel.fromJson(value.data()!);
          emit(SocialGetUserDataSuccessState());
    })
        .catchError((error) {
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }

  void updateUserData({
    required String firstName,
    required String lastName,
    String? pic,
    String? coverPic,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateUserDataLoadingState());

    UsersModel model = UsersModel(
      firstName: firstName,
      lastName: lastName,
      email: userModel!.email,
      phone: phone,
      pic: pic ?? userModel!.pic,
      coverPic: coverPic ?? userModel!.coverPic,
      bio: bio,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
          getUserData();
    }).catchError((error){
      emit(SocialUpdateUserDataErrorState(error.toString()));
    });
  }

  File? profileImage;
  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      emit(SocialPickedProfileImageSuccessState());
    }
    else{
      print('No Image Selected');
      emit(SocialPickedProfileImageErrorState());
    }
    }


  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      coverImage = File(pickedFile.path);
      emit(SocialPickedCoverImageSuccessState());
    }
    else{
      print('No Image Selected');
      emit(SocialPickedCoverImageErrorState());
    }
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      postImage = File(pickedFile.path);
      emit(SocialPickedPostImageSuccessState());
    }
    else{
      print('No Image Selected');
      emit(SocialPickedPostImageErrorState());
    }
  }

  File? chatImage;

  Future<void> getChatImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      chatImage = File(pickedFile.path);
      emit(SocialPickedChatImageSuccessState());
    }
    else{
      print('No Image Selected');
      emit(SocialPickedChatImageErrorState());
    }
  }

  Future<void> uploadChatImage(
      {
        required String receiverId,
        required String msgDateTime,
        required String msgText,
      }
      )
  async {
    emit(SocialAddNewPostLoadingState());

    FirebaseStorage.instance.ref().child('Users/Chat/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        sendMsg(
            receiverId: receiverId,
            msgDateTime: msgDateTime,
            msgText: msgText,
            chatPic: value);
      }).catchError((error){
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error){
      print('error: ${error.toString()}');
      emit(SocialUploadCoverImageErrorState());
    });
  }


  void uploadProfileImage(
      {
        required String firstName,
        required String lastName,
        String? pic,
        String? coverPic,
        required String bio,
        required String phone,
      }
      )
  {
    emit(SocialUploadProfileImageLoadingState());

    FirebaseStorage.instance.ref()
        .child('Users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL().then((value) {
            print('url: $value');
              updateUserData(firstName: firstName,
                  lastName: lastName,
                  pic: value,
                  bio: bio,
                  phone: phone,
              );
              emit(SocialUploadProfileImageSuccessState());
          }).catchError((error){
            emit(SocialUploadProfileImageErrorState());
          });
    }).catchError((error){
      print('error: ${error.toString()}');
      emit(SocialUploadProfileImageErrorState());
    });
  }


  void uploadCoverImage(
      {
        required String firstName,
        required String lastName,
        String? pic,
        String? coverPic,
        required String bio,
        required String phone,
      }
      )
  {
    emit(SocialUploadCoverImageLoadingState());

    FirebaseStorage.instance.ref().child('Users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
          updateUserData(firstName: firstName,
              lastName: lastName,
              coverPic: value,
              bio: bio,
              phone: phone,
          );
          emit(SocialUploadCoverImageSuccessState());
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error){
      print('error: ${error.toString()}');
      emit(SocialUploadCoverImageErrorState());
    });
  }

  Future<void> uploadPostImage(
      {
        required String dateTime,
        required String postText,
        String? postPic,
      }
      )
  async {
    emit(SocialAddNewPostLoadingState());

    FirebaseStorage.instance.ref().child('Posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        addNewPost(
          dateTime: dateTime,
          postText: postText,
          postPic: value
        );
      }).catchError((error){
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error){
      print('error: ${error.toString()}');
      emit(SocialUploadPostImageErrorState());
    });
  }

  Future<void> addNewPost({
    required String dateTime,
    required String postText,
    String? postPic,
  }) async {
    emit(SocialAddNewPostLoadingState());

    PostsModel model = PostsModel(
      firstName: userModel!.firstName,
      lastName: userModel!.lastName,
      postText: postText,
      postDateTime: dateTime,
      pic: userModel!.pic,
      postImage: postPic,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .add(model.toMap())
        .then((value) {
          // FirebaseFirestore.instance.collection('Posts').doc(postId).collection('like').doc(uId).set(
          //     {'like': false});
          emit(SocialAddNewPostSuccessState());
    }).catchError((error){
      emit(SocialAddNewPostErrorState());
    });
  }

  Future<void> sendMsg({
    required String receiverId,
    required String msgDateTime,
    required String msgText,
    String? chatPic,
  }) async {
    ChatModel model = ChatModel(
      senderId: uId,
      receiverId: receiverId,
      msgDateTime: msgDateTime,
      msgText: msgText,
      msgPic: chatPic
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMsgSuccessState());
    }).catchError((error){
      emit(SocialSendMsgErrorState());
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .collection('Chats')
        .doc(uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMsgSuccessState());
    }).catchError((error){
      emit(SocialSendMsgErrorState());
    });
  }

  List<ChatModel> messages = [];

  void getMessages({
  required String receiverId
}){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .collection('Chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('msgDateTime')
        .snapshots()
        .listen((event) {

          messages = [];

          for (var element in event.docs) {
            messages.add(ChatModel.fromJson(element.data()));
          }

          emit(SocialGetMsgsSuccessState());
    });
  }

  void removePostImage(){

    postImage = null;
    emit(SocialRemovePostImage());
  }

  void removeChatImage(){

    chatImage = null;
    emit(SocialRemoveChatImage());
  }

  List posts = [];

  List postsId = [];

  List likes = [];

  List comments = [];

  List<UsersModel> users = [];

  // Map<String, bool> isLiked = {};

  // bool isLiked = false;

  Future getPosts() async {
    posts = [];
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .get().then((value) {
        for (var element in value.docs) {


          // isLiked.addAll({element.id: false});
          element.reference.collection('comments').get().then((value) {
            emit(SocialGetCommentsLoadingState());
            comments.add(value.docs.length);
            // value.docs.forEach((element) {
            //   element.reference.get().then((value) {
            //     print('Value: ${value.data()?.length}');
            //     comments.add(value.data()?.length);
            //   });
            // });
            element.reference.collection('likes').get().then((value) {
              emit(SocialGetLikesLoadingState());
              likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(PostsModel.fromJson(element.data()));
              emit(SocialGetLikesSuccessState());

              // value.docs.forEach((e) {
              //   isLiked.addAll({}
              //     // element.id : e.data()[1]
              //     // e.data()
              //   );
              //   print('isLiked: ${e.data}');
              // });
            }).catchError((error){
              emit(SocialGetLikesErrorState(error.toString()));
            });
            emit(SocialGetCommentsSuccessState());
          }).catchError((error){
            emit(SocialGetCommentsErrorState(error.toString()));

          });

        }

        emit(SocialGetPostsSuccessState());
    }).catchError((error){
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  Future getUsers() async {
    users = [];
    emit(SocialGetUsersLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .get().then((value) {
      for (var element in value.docs) {
        if(element.data()['uId'] != uId) {
          users.add(UsersModel.fromJson(element.data()));
        }

      }

      emit(SocialGetUsersSuccessState());
    }).catchError((error){
      emit(SocialGetUsersErrorState(error.toString()));
    });
  }

  // void getLikes(){
  //   // emit(SocialGetPostsLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('Posts').get().then((value) {
  //         value.docs.forEach((element) {
  //           element.reference.collection('likes').
  //         })
  //   }).catchError((error){});
  //
  // }

  // List<Map<String, Color>> likeColor = [];


    // postsId.

  // void test(postId){
  //   // FirebaseFirestore.instance.collection('Posts').doc(postId).collection('likes')
  //   postsId.forEach((element) {
  //     isLiked.addAll({
  //       element: false
  //     });
  //     });
  //   print(isLiked);
  // }
  
  // void togglePostsLikeAndDislike(String postId, index){
  //   isLiked = !isLiked;
  //   if(isLiked){
  //     likeColor[index][postId] = Colors.red;
  //   } else{
  //     likeColor[index][postId] = Colors.black;
  //   }
  //   emit(SocialChangePostLikeState());
  // }

  void postLike(String postId){
    // isLiked = !isLiked;
    // togglePostsLikeAndDislike(postId, index);
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('likes')
        .doc(uId)
        .set({
      'like': true
    })
        .then((value) {
          emit(SocialLikePostSuccessState());
    }).catchError((error){
      emit(SocialLikePostErrorState());
    });
  }

  void postComment(String postId, String comment){
    // isLiked = !isLiked;
    // togglePostsLikeAndDislike(postId, index);
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comments')
        .doc(uId)
        .update({
      '${DateTime.now()}': comment
    })
        .then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error){
      emit(SocialCommentPostErrorState());
    });
  }

  // void postDisLike(String postId){
  //   isLiked = !isLiked;
  //   // togglePostsLikeAndDislike(postId, index);
  //   FirebaseFirestore.instance
  //       .collection('Posts')
  //       .doc(postId)
  //       .collection('likes')
  //       .doc(uId)
  //       .set({
  //     'like': false
  //       })
  //       .then((value) {
  //     emit(SocialLikePostSuccessState());
  //   }).catchError((error){
  //     emit(SocialLikePostErrorState());
  //   });
  // }

  int currentIndex = 0;

  void changeBotNavBar(index){
    if(index == 1){
      getUsers();
    }
    // if(index == 0){
    //   getPosts();
    // }
      currentIndex = index;
      emit(SocialChangeBotNavBarState());


  }

  List<Widget> screens = [
    NewsFeedScreen(),
    ChatScreen(),
    // NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> titles = [
    'News Feed',
    'Chat',
    // 'New Post',
    'Users',
    'Settings',
  ];
}



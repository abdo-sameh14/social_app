import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/modules/chats_screen/chat_screen.dart';
import 'package:social_app/modules/new_post_screen/new_post_screen.dart';
import 'package:social_app/modules/news_feed_screen/news_feed_screen.dart';
import 'package:social_app/modules/settings_screen/settings_screen.dart';
import 'package:social_app/modules/users_screen/users_screen.dart';
import 'package:social_app/shared/components/components.dart';

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

    firebase_storage.FirebaseStorage.instance.ref()
        .child('Users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL().then((value) {
            print('url: $value');
            if(value != null){
              updateUserData(firstName: firstName,
                  lastName: lastName,
                  pic: value,
                  bio: bio,
                  phone: phone,
              );
              emit(SocialUploadProfileImageSuccessState());
            }
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

    firebase_storage.FirebaseStorage.instance.ref().child('Users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        if(value !=null){
          updateUserData(firstName: firstName,
              lastName: lastName,
              coverPic: value,
              bio: bio,
              phone: phone,
          );
          emit(SocialUploadCoverImageSuccessState());
        }

      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error){
      print('error: ${error.toString()}');
      emit(SocialUploadCoverImageErrorState());
    });
  }

  int currentIndex = 0;

  void changeBotNavBar(index){
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



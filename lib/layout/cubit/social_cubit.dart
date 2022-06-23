import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/users_model.dart';

import '../../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UsersModel? model;

  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .get()
        .then((value) {
          model = UsersModel.fromJson(value.data()!);
          emit(SocialGetUserDataSuccessState());
    })
        .catchError((error) {
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }
}

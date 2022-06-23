import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/modules/register_screen/register_states.dart';


class RegisterScreenCubit extends Cubit<RegisterScreenStates> {
  RegisterScreenCubit() : super(RegisterScreenInitialState());

  static RegisterScreenCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
  }){
    emit(RegisterScreenLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,

    ).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      createUser(firstName: firstName, lastName: lastName, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((error){
      print(error.toString());
      emit(RegisterScreenErrorState(error.toString()));
    });
  }



  void createUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String uId,
  }){
    UsersModel model = UsersModel(
        firstName,
        lastName,
        phone,
        uId
    );

    FirebaseFirestore.instance
        .collection('Users').doc(uId)
        .set(model.toMap()).then((value){
          emit(RegisterScreenCreateUserSuccessState(uId));
    }).catchError((error){
      emit(RegisterScreenCreateUserErrorState(error.toString()));
    });
  }


  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility(){
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterScreenChangePasswordVisibility());
  }

  // bool onBoarding = true;

  // void submit(context){
  //   CacheHelper.setData(key: 'onBoarding', value: false).then((value) {
  //     print(value);
  //     onBoarding = value!;
  //     if (onBoarding = false){
  //       navigateAndReplaceTo(context, RegisterScreen());
  //     }
  //   });
  // }

}
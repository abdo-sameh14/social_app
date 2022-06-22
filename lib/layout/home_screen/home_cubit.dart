import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/home_screen/home_states.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit() : super(HomeScreenInitialState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);



  int currentIndex = 0;

  void changeBotNavBar(int index){
    currentIndex = index;
    emit(HomeScreenChangeBotNavBar());
  }
  List<Widget> navBarScreens = [
    // ProductScreen(),
    // const CategoriesScreen(),
    // const FavouritesScreen(),
    // SettingsScreen(),
  ];
  
}
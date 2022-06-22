import 'package:flutter/material.dart';

import '../modules/login_screen/login_screen.dart';
import '../modules/onBoarding_screen/onBoarding_screen.dart';
import '../shared/components/components.dart';
import '../shared/network/local/chache _helper.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Salla'.toUpperCase(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                navigateTo(context, OnBoardingScreen());
              },
              icon: Icon(Icons.info_outline_rounded),
          ),
          IconButton(
              onPressed: (){
                CacheHelper.removeData(key: 'token').then((value)
                => navigateAndReplaceTo(context, LoginScreen())
                );
              },
              icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
    );
  }
}

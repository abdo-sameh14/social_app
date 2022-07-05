import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/shared/network/local/chache%20_helper.dart';
import 'firebase_options.dart';
import 'layout/cubit/social_states.dart';
import 'modules/login_screen/login_screen.dart';
import 'modules/onBoarding_screen/onBoarding_screen.dart';
import 'shared/components/constants.dart';
import 'shared/bloc_observer.dart';
import 'shared/styles/themes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main(context) async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final fcmToken = await FirebaseMessaging.instance.getToken();
      print('token: $fcmToken');

      FirebaseMessaging.onMessage.listen((event) {
        print('Data: ${event.data.toString()}');
      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print('Data: ${event.data.toString()}');
      });

      // final prefs = await SharedPreferences.getInstance();
      // show = prefs.getBool('INTRODUCTION') ?? true;
      // DioHelper.init();
      await CacheHelper.init();
      final bool? isDark = CacheHelper?.getBool(key: 'isDark');
      bool? onBoarding = CacheHelper?.getData(key: 'onBoarding') ?? false;
      // token = CacheHelper?.getData(key: 'token');
      uId = CacheHelper?.getData(key: 'uId');
      // print('Token = $token');
      print('uID = $uId');

      final Widget widget;
      if(onBoarding!){
        if(uId != null){
          widget = const SocialLayoutScreen();
        }else{
          widget = LoginScreen();
        }
      }else{
        widget = OnBoardingScreen();
      }
      // print('onBoarding = $onBoarding');
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  const MyApp({Key? key, this.isDark, this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (BuildContext context) => HomeScreenCubit(),
        // ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          // bool darkModeOn = ShopCubit.get(context).darkMode;
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              home: startWidget
              // onBoarding! ? LoginScreen() : OnBoardingScreen()
              //     if(onBoarding = null || onBoarding = true){
              //     return OnBoardingScreen();
              // }
              // else{
              //   return LoginnScreen();
              // }
              // onBoarding! ? OnBoardingScreen() : LoginScreen()
              // const ShopLayoutScreen(),
              );
        },
      ),
    );
  }
}

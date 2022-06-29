import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/chache%20_helper.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../modules/new_post_screen/new_post_screen.dart';

class SocialLayoutScreen extends StatelessWidget {
  const SocialLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            if(state is SocialAddPostState)
           {
             SocialCubit.get(context).currentIndex = 0;
             navigateTo(context, NewPostScreen());
            }
          },
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            // print(FirebaseAuth.instance.currentUser!.emailVerified);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  cubit.titles[cubit.currentIndex],
                ),
                actions: [
                  IconButton(
                    icon: const Icon(IconBroken.Logout),
                    onPressed: (){
                      FirebaseAuth.instance.signOut();
                      CacheHelper.removeData(key: 'uId');
                      uId = null;
                      navigateAndReplaceTo(context, LoginScreen());
                    },
                  ),
                  IconButton(
                    icon: const Icon(IconBroken.Notification),
                    onPressed: (){
                    },
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigateTo(context, NewPostScreen());
                },
                tooltip: 'Add Post',
                backgroundColor: defaultColor,
                child: Icon(
                  IconBroken.Paper_Plus,
                  size: 30,
                ),
                // mini: true,
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home),
                    label: 'Home',

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat),
                    label: 'Chat',
                  ),

                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.add_circle_outline),
                  //   label: 'Post',
                  // ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.User),
                    label: 'Users',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting),
                    label: 'Settings',
                  ),
                ],
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeBotNavBar(index);
                },

              ),
              body: cubit.screens[cubit.currentIndex],
            );
          },
        );
  }
}
// ConditionalBuilder(
//   condition: SocialCubit.get(context).model != null,
//   builder: (context) => Column(
//     children: [
//       if(!FirebaseAuth.instance.currentUser!.emailVerified)
//           Container(
//             color: Colors.amber.withOpacity(0.7),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.info_outline,
//                     // color: Colors.white,
//                     size: 18,
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   const Expanded(
//                     child: Text(
//                       'Please Verify Your Email...',
//                       style: TextStyle(
//                         color: Colors.black,
//                         // fontWeight: FontWeight.normal,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       FirebaseAuth.instance.currentUser
//                           ?.sendEmailVerification().then((value) {
//                         showToast(msg: 'Check your mail',
//                             state: ToastStates.success);
//                       });
//                     },
//                     child: const Text(
//                       'Send Verification Email',
//                       style: TextStyle(
//                           fontSize: 14
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     ],
//   ),
//   fallback: (context) => const Center(child: CircularProgressIndicator()),
// ),
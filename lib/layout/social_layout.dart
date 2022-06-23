import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/chache%20_helper.dart';

class SocialLayoutScreen extends StatelessWidget {
  const SocialLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            // print(FirebaseAuth.instance.currentUser!.emailVerified);
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'News Feed',
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: (){
                      FirebaseAuth.instance.signOut();
                      CacheHelper.removeData(key: 'uId');
                      uId = null;
                      navigateAndReplaceTo(context, LoginScreen());
                    },
                  )
                ],
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).model != null,
                builder: (context) => Column(
                  children: [
                    if(!FirebaseAuth.instance.currentUser!.emailVerified)
                        Container(
                          color: Colors.amber.withOpacity(0.7),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  // color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Expanded(
                                  child: Text(
                                    'Please Verify Your Email...',
                                    style: TextStyle(
                                      color: Colors.black,
                                      // fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.currentUser
                                        ?.sendEmailVerification().then((value) {
                                      showToast(msg: 'Check your mail',
                                          state: ToastStates.success);
                                    });
                                  },
                                  child: const Text(
                                    'Send Verification Email',
                                    style: TextStyle(
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ],
                ),
                fallback: (context) => const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
  }
}

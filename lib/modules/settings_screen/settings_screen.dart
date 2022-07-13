import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/modules/edit_profile_screen/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 60),
                      child: InkWell(
                        child: Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                  image: NetworkImage(model!.coverPic!),
                                  fit: BoxFit.cover),
                              color: defaultColor),
                        ),
                        onTap: () {
                          openImage(
                            context: context,
                            imageProvider: NetworkImage(model.coverPic!),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      child: CircleAvatar(
                        radius: 62,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: defaultColor,
                          backgroundImage: NetworkImage(model.pic!),
                        ),
                      ),
                      onTap: () {
                        openImage(
                            context: context,
                            imageProvider: NetworkImage(model.pic!));
                      },
                      // enableFeedback: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${model.firstName} ${model.lastName}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(model.bio!, style: Theme.of(context).textTheme.caption),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              Text('Posts',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '60',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              Text('Media',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '10K',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              Text('Followers',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '200',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              Text('Following',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Add Photos',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: defaultColor,
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: const Icon(IconBroken.Edit),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance
                              .subscribeToTopic('announcement');
                        },
                        child: const Text('Subscribe'),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance
                              .unsubscribeFromTopic('announcement');
                        },
                        child: const Text('Unsubscribe'),
                      ),
                    ),
                  ],
                ),

                // defaultButton(
                //   function: (){},
                //   text: 'Edit Profile',
                //   radius: 4,
                //   backgroundColor: Colors.blue
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

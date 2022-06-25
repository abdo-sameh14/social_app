import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
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
        var model = SocialCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 60),
                    child: InkWell(
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(),
                            image: DecorationImage(
                                image: NetworkImage(
                                  model!.coverPic!
                                  // 'https://img.freepik.com/free-photo/happy-smiling-millennial-girl-with-red-hair-holds-modern-cellular-enjoys-texting-social-media-uses-mobile-network-services-wears-blue-jumper-hat_273609-46497.jpg',
                                ),
                                fit: BoxFit.cover
                            ),
                            color: defaultColor
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                  InkWell(
                    child: CircleAvatar(
                      radius: 62,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: defaultColor,
                        backgroundImage: NetworkImage(
                            model.pic!
                        ),
                      ),
                    ),
                    onTap: (){},
                    // enableFeedback: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${model.firstName} ${model.lastName}',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 24
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.bio!,
                style: Theme.of(context).textTheme.caption
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '60',
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                                'Media',
                                style: Theme.of(context).textTheme.caption
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10K',
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '200',
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                                'Following',
                                style: Theme.of(context).textTheme.caption
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: Text(
                        'Add Photos',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: defaultColor,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  OutlinedButton(
                    onPressed: (){},
                    child: const Icon(
                        IconBroken.Edit
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
        );
      },
    );
  }
}

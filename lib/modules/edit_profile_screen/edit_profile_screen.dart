import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../layout/cubit/social_states.dart';
import '../../shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).model;
        var cubit = SocialCubit.get(context);
        firstNameController.text = model!.firstName!;
        lastNameController.text = model.lastName!;
        bioController.text = model.bio!;
        phoneController.text = model.phone!;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            action: [
              TextButton(
                onPressed: (){
                  cubit.updateUserData();
                },
                child: const Text(
                  'Update',
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 60),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            InkWell(
                              child: Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            model.coverPic!
                                        ),
                                        fit: BoxFit.cover
                                    ),
                                    color: defaultColor
                                ),
                              ),
                              onTap: (){
                                openImage(context: context, image: model.coverPic!);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: defaultColor,
                                child: IconButton(
                                    onPressed: (){},
                                    icon: const Icon(
                                      IconBroken.Camera,
                                      size: 26,
                                    ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
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
                            onTap: (){
                              openImage(context: context, image: model.pic!);
                            },
                            // enableFeedback: true,
                          ),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: defaultColor,
                            child: IconButton(
                              onPressed: (){},
                              icon: const Icon(
                                IconBroken.Camera,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: defaultTextFormField(
                            label: 'First Name',
                            type: TextInputType.name,
                            controller: firstNameController,
                            validateReturn: 'Please Entre Your First Name',
                            prefix: IconBroken.User,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: defaultTextFormField(
                          label: 'Last Name',
                          type: TextInputType.name,
                          controller: lastNameController,
                          validateReturn: 'Please Entre Your Last Name',
                          prefix: IconBroken.User,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    label: 'Bio',
                    type: TextInputType.text,
                    controller: bioController,
                    validateReturn: 'Please Entre Your Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    label: 'Phone',
                    type: TextInputType.phone,
                    controller: phoneController,
                    validateReturn: 'Please Entre Your Phone',
                    prefix: IconBroken.Info_Circle,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

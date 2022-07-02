import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/users_model/users_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';

import '../../shared/styles/colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        List users = cubit.users;
        return ConditionalBuilder(
          condition: users.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(context, users[index]),
              separatorBuilder: (context, index) => mySeparator(),
              itemCount: users.length),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(context, UsersModel model){
     return InkWell(
        onTap: (){},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    model.pic!
                  // 'https://img.freepik.com/free-photo/happy-smiling-millennial-girl-with-red-hair-holds-modern-cellular-enjoys-texting-social-media-uses-mobile-network-services-wears-blue-jumper-hat_273609-46497.jpg',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  '${model.firstName!} ${model.lastName!}',
                  // 'Abdo Sameh',
                  style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(
                      height: 1
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      );


  }
}

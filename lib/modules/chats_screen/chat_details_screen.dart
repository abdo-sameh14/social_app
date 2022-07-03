import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../models/users_model/users_model.dart';
import '../../shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {

  UsersModel usersModel;

  ChatDetailsScreen({Key? key,
    required this.usersModel
}) : super(key: key);

  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: Theme.of(context).appBarTheme.iconTheme?.color,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      usersModel.pic!
                    // 'https://img.freepik.com/free-photo/happy-smiling-millennial-girl-with-red-hair-holds-modern-cellular-enjoys-texting-social-media-uses-mobile-network-services-wears-blue-jumper-hat_273609-46497.jpg',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    '${usersModel.firstName!} ${usersModel.lastName!}',
                    // 'Abdo Sameh',
                    style:
                    Theme.of(context).textTheme.bodyText1?.copyWith(
                        height: 1
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(10),
                          topEnd: Radius.circular(10),
                          topStart: Radius.circular(10),
                        )
                    ),
                    child: const Text(
                      'Hello',
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10
                    ),
                    decoration: BoxDecoration(
                        color: defaultColor.withOpacity(0.3),
                        borderRadius: const BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(10),
                          topEnd: Radius.circular(10),
                          topStart: Radius.circular(10),
                        )
                    ),
                    child: const Text(
                      'Hello',
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: 10,
                  //   vertical: 5
                  // ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(15),
                    // color: Colors.grey[200],
                    border: Border.all(
                      color: Colors.grey[300]!,
                    ),
                    // gradient: LinearGradient(
                    //   colors: [
                    //     defaultColor,
                    //     Colors.deepOrange
                    // ],
                    //
                    // ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15
                          ),
                          child: TextFormField(
                            controller: msgController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your message here...',

                            ),

                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 10
                      //   ),
                      //   child: IconButton(
                      //     onPressed: (){
                      //       cubit.sendMsg(receiverId: usersModel.uId!, msgDateTime: DateTime.now().toString(), msgText: msgController.text).then((value) {
                      //         msgController.clear();
                      //       });
                      //     },
                      //     icon: const Icon(
                      //       IconBroken.Send,
                      //     ),
                      //     color: defaultColor,
                      //   ),
                      // ),
                      Container(
                        color: defaultColor,
                        // height: 50,
                        child: MaterialButton(
                          onPressed: (){},
                          minWidth: 1,
                          child: const Icon(
                            IconBroken.Send,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 12
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

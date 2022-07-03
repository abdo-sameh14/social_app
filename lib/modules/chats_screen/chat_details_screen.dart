import 'dart:ffi';
import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/chat_model/chat_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../models/users_model/users_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {

  UsersModel usersModel;

  ChatDetailsScreen({Key? key,
    required this.usersModel
}) : super(key: key);

  TextEditingController msgController = TextEditingController();
  ScrollController listScrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: usersModel.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var key = GlobalKey<FormState>();
          var cubit = SocialCubit.get(context);
          List<ChatModel> messages = cubit.messages;
          File? chatImage = cubit.chatImage;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                ),
                onPressed: (){
                  cubit.removeChatImage();
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
            body: Form(
              key: key,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: messages.isNotEmpty,
                        builder: (context) => ListView.separated(
                          dragStartBehavior: DragStartBehavior.down,
                          controller: listScrollController,
                          physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              if(messages[index].senderId == uId){
                                return buildMyMsg(messages[index], context);

                              }
                              else{
                                return buildOthersMsg(messages[index], context);
                              }
                            },
                            separatorBuilder: (context, index) => const SizedBox(height: 15,),
                            itemCount: messages.length),
                        fallback: (context) =>
                            Center(child: Text(
                              'There\'s no chat history between you and ${usersModel.firstName} ${usersModel.lastName}, start chatting by saying Hi...',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 14,
                                height: 1.5
                              ),
                            ),),
                      ),
                    ),
                    if(chatImage !=null)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 15
                        ),
                        child: Card(
                          // margin: const EdgeInsets.all(8),
                          elevation: 5,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              InkWell(
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                          image: FileImage(chatImage),
                                          fit: BoxFit.cover
                                      ),
                                      color: defaultColor
                                  ),
                                ),
                                onTap: (){
                                  openImage(context: context, imageProvider: FileImage(chatImage));
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: defaultColor,
                                  child: IconButton(
                                    onPressed: (){
                                      cubit.removeChatImage();
                                    },
                                    icon: const Icon(
                                      IconBroken.Close_Square,
                                      size: 22,
                                    ),
                                    // alignment: AlignmentDirectional.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // if(chatImage !=null)
                    SizedBox(
                      height: 10,
                    ),
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
                                // validator: (value){
                                //   if(value.isNotEmpty)
                                // },
                                controller: msgController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your message here...',

                                ),

                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(IconBroken.Camera,),
                            onPressed: (){
                              cubit.getChatImage();
                            },
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
                              onPressed: (){
                                if(chatImage !=null || msgController.text.isNotEmpty){
                                  chatImage == null ? cubit.sendMsg(receiverId: usersModel.uId!, msgDateTime: DateTime.now().toString(), msgText: msgController.text)
                                      : cubit.uploadChatImage(receiverId: usersModel.uId!, msgDateTime: DateTime.now().toString(), msgText: msgController.text);
                                  msgController.clear();
                                  cubit.removeChatImage();
                                }
                              },
                              minWidth: 1,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 12
                              ),
                              child: const Icon(
                                IconBroken.Send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
      },
    );
  }

  Widget buildMyMsg(ChatModel model, context) => Align(
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
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start  ,
        children: [
          if(model.msgText! != null)
            Text(
            model.msgText!,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          if(model.msgText! != null && model.msgPic != null)
            SizedBox(
              height: 10,
            ),
          if(model.msgPic != null)
            Center(
              child: InkWell(
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: NetworkImage(
                          model.msgPic!,
                        ),
                        fit: BoxFit.cover
                    ),
                    color: defaultColor
                ),
              ),
              onTap: (){
                openImage(context: context, imageProvider: NetworkImage(
                  model.msgPic!,
                ),);
              },
          ),
            ),
        ],
      ),
    ),
  );

  Widget buildOthersMsg(ChatModel model, context) => Align(
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
      child: Column(
        children: [
          if(model.msgText! != null)
            Text(
              model.msgText!,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          if(model.msgText! != null && model.msgPic != null)
            SizedBox(
              height: 10,
            ),
          if(model.msgPic != null)
            Center(
              child: InkWell(
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                          image: NetworkImage(
                            model.msgPic!,
                          ),
                          fit: BoxFit.cover
                      ),
                      color: defaultColor
                  ),
                ),
                onTap: (){
                  openImage(context: context, imageProvider: NetworkImage(
                    model.msgPic!,
                  ),);
                },
              ),
            ),
        ],
      ),
    ),
  );
}

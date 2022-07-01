import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/shared/components/components.dart';

import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialAddNewPostSuccessState){
          showToast(msg: 'Post Added Successfully', state: ToastStates.success);
          Navigator.pop(context);
          SocialCubit.get(context).removePostImage();
          SocialCubit.get(context).getPosts();
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var postImage = cubit.postImage;
        var model = cubit.userModel;
        var now = DateTime.now();
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            backArrowFunction: (){
              cubit.removePostImage();
            },
            action: [
              TextButton(
                onPressed: ()async{
                 cubit.postImage == null ?
                 cubit.addNewPost(dateTime: now.toString(), postText: postController.text).then((value) {
                 // cubit.getPosts();
                 })
                      : cubit.uploadPostImage(dateTime: now.toString(), postText: postController.text).then((value) {
                   // cubit.getPosts();
                 });

                },
                child: const Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SocialAddNewPostLoadingState)
                    const LinearProgressIndicator(),
                  if(state is SocialAddNewPostLoadingState)
                    const SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          // 'https://img.freepik.com/free-photo/happy-smiling-millennial-girl-with-red-hair-holds-modern-cellular-enjoys-texting-social-media-uses-mobile-network-services-wears-blue-jumper-hat_273609-46497.jpg',
                          model!.pic!
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${model.firstName} ${model.lastName}',
                              style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                  height: 1
                              ),
                            ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            // Text(
                            //   'Fri, Jun 24, at 7:00 pm',
                            //   style: Theme.of(context).textTheme.caption,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: postController,
                    decoration: const InputDecoration(
                        label: Text('New Post'),
                        hintText: 'What\'s happening?',
                        border: InputBorder.none
                    ),
                  ),
                  if(postImage !=null)
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Card(
                        // margin: const EdgeInsets.all(8),
                        elevation: 5,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            InkWell(
                            child: Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                      image: FileImage(postImage),
                                      fit: BoxFit.cover
                                  ),
                                  color: defaultColor
                              ),
                            ),
                            onTap: (){
                              openImage(context: context, imageProvider: FileImage(postImage));
                            },
                  ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: defaultColor,
                                child: IconButton(
                                  onPressed: (){
                                    cubit.removePostImage();
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Add Image',
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.tag_rounded,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Tags',
                                style: TextStyle(
                                  fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

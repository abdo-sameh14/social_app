import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/posts_model/post_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class NewsFeedScreen extends StatelessWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var posts = cubit.posts;
        var likes = cubit.likes;
        var comments = cubit.comments;
        return ConditionalBuilder(
            condition:
            // likes.isNotEmpty && comments.isNotEmpty && cubit.userModel != null,
            posts.isNotEmpty && likes.isNotEmpty && comments.isNotEmpty && cubit.userModel != null,
            builder: (context) => RefreshIndicator(
              onRefresh: (){
                return cubit.getPosts();
              },
              // showChildOpacityTransition: false,
              color: defaultColor,
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        const Image(
                          image: NetworkImage(
                            'https://img.freepik.com/free-photo/beautiful-asian-woman-uses-smartphone-app-sends-messages-social-media-chat-points-away-copy-space-wears-casual-jumper_273609-48643.jpg',
                          ),
                          fit: BoxFit.cover,
                          height: 250,
                          width: double.infinity,
                        ),
                        Text(
                          '''Communicate
With Friends        
''',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            // color: Colors.white,
                              fontSize: 22),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(cubit.posts[index], context, index),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    itemCount: posts.length,
                  ),
                ],
              ),
          ),
            ),
            fallback: (context) => const Align(
              alignment: Alignment.topCenter,
              child: Center(child: CircularProgressIndicator()),
            )
        );
      },
    );
  }


}
Widget buildPostItem(PostsModel model, context, index) {
  TextEditingController commentController = TextEditingController();
  return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      elevation: 3,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${model.firstName!} ${model.lastName!}',
                            style:
                            Theme.of(context).textTheme.bodyText1?.copyWith(
                                height: 1
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        model.postDateTime!,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Text(
              model.postText ?? '',
              // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                children: [
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      height: 25,
                      child: Text(
                        '#Social',
                        style: Theme.of(context).textTheme
                            .bodyText2?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      height: 25,
                      child: Text(
                        '#Social',
                        style: Theme.of(context).textTheme
                            .bodyText2?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      height: 25,
                      child: Text(
                        '#Social',
                        style: Theme.of(context).textTheme
                            .bodyText2?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      height: 25,
                      child: Text(
                        '#Social',
                        style: Theme.of(context).textTheme
                            .bodyText2?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      height: 25,
                      child: Text(
                        '#Social',
                        style: Theme.of(context).textTheme
                            .bodyText2?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      height: 25,
                      child: Text(
                        '#Social',
                        style: Theme.of(context).textTheme
                            .bodyText2?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      height: 25,
                      child: Text(
                        '#Social',
                        style: Theme.of(context).textTheme
                            .bodyText2?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      height: 25,
                      child: Text(
                        '#Social',
                        style: Theme.of(context).textTheme
                            .bodyText2?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      height: 25,
                      child: Text(
                        '#Social',
                        style: Theme.of(context).textTheme
                            .bodyText2?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if(model.postImage != null)
              InkWell(
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: NetworkImage(
                          model.postImage!
                          // 'https://img.freepik.com/free-photo/happy-smiling-millennial-girl-with-red-hair-holds-modern-cellular-enjoys-texting-social-media-uses-mobile-network-services-wears-blue-jumper-hat_273609-46497.jpg',
                        ),
                        fit: BoxFit.cover
                    )
                ),
              ),
              onTap: (){
                openImage(context: context, imageProvider: NetworkImage(model.postImage!));
              },
            ),
            if(model.postImage != null)
              const SizedBox(
              height: 10,
              ),
            Row(
              children: [
                InkWell(
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${SocialCubit.get(context).likes[index]}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.5
                        ),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
                const Spacer(),
                InkWell(
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Chat,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(

                        // '0 comments',
                        '${SocialCubit.get(context).comments[index] ?? 0} comments',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.5
                        ),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    SocialCubit.get(context).userModel!.pic!
                    // 'https://img.freepik.com/free-photo/happy-smiling-millennial-girl-with-red-hair-holds-modern-cellular-enjoys-texting-social-media-uses-mobile-network-services-wears-blue-jumper-hat_273609-46497.jpg',
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    decoration:  const InputDecoration(
                      hintText: 'write a comment...',
                      border: InputBorder.none
                    ),
                    onFieldSubmitted: (value){
                      SocialCubit.get(context).postComment(SocialCubit.get(context).postsId[index], value);
                    },
                  ),
                  // InkWell(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 15),
                  //     child: Text(
                  //       'write a comment...',
                  //       style: Theme.of(context).textTheme.caption,
                  //     ),
                  //   ),
                  //   onTap: (){},
                  // ),
                ),
                IconButton(
                  onPressed: (){
                    SocialCubit.get(context).postLike(SocialCubit.get(context).postsId[index]);
                    // SocialCubit.get(context).test(SocialCubit.get(context).postsId[index]);
                    // if(SocialCubit.get(context).isLiked){
                    //   SocialCubit.get(context).postDisLike(SocialCubit.get(context).postsId[index]);
                    // }else if(!SocialCubit.get(context).isLiked){
                    //   SocialCubit.get(context).postLike(SocialCubit.get(context).postsId[index]);
                    // }
                    //SocialCubit.get(context).isLiked ? SocialCubit.get(context).postDisLike(SocialCubit.get(context).postsId[index]);
                  },
                  icon: const Icon(
                    IconBroken.Heart,
                    // color:  Colors.black,
                    // SocialCubit.get(context).isLiked[SocialCubit.get(context).postsId[index]]! ? Colors.red : Colors.black

                  ),
                ),
              ],
            ),
          ],),
      ),
    );
}


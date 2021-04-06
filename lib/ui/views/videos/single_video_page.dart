import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/videos/AddCommentToVideoRequest.dart';
import 'package:phinex/Bles/Model/responses/video/SingleVideoResponse.dart';
import 'package:phinex/Bles/bloc/video/VideoBloc.dart';
import 'package:phinex/ui/views/chats/profile/person_profile_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button2.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'video_cart_item.dart';

class SingleVideoPage extends StatefulWidget {
  final videoId;

  const SingleVideoPage({Key key, @required this.videoId}) : super(key: key);

  @override
  _SingleVideoPageState createState() => _SingleVideoPageState();
}

class _SingleVideoPageState extends State<SingleVideoPage> {
  bool addComment = false;

  TextEditingController textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  int take = 10;
  int skip = 0;

  @override
  void initState() {
    super.initState();

    videoBloc.getSingle(widget.videoId);
  }

  @override
  Widget build(BuildContext context) {
    videoBloc.getVideoComments(
        BaseRequestSkipTake(id: widget.videoId, skip: 0, take: 10),
    );
    return Scaffold(
      appBar: myAppBar(AppUtils.translate(context, 'funny_videos'), context),
      body: StreamBuilder<SingleVideoResponse>(
        stream: videoBloc.single.stream,
        builder: (context, snapshot) {
          if (videoBloc.loading.value) {
            return Loader();
          } else {
            _scrollController
              ..addListener(
                () {
                  if (_scrollController.position.pixels ==
                      _scrollController.position.maxScrollExtent) {
                    skip += 10;
                    take += 10;
                    videoBloc.getVideoComments(
                      BaseRequestSkipTake(
                        skip: skip,
                        take: take,
                        id: widget.videoId,
                      ),
                    );
                  }
                },
              );
            return SingleChildScrollView(
              controller: _scrollController,
              physics: bouncingScrollPhysics,
              child: Column(
                children: [
                  VideoCardItem(
                    userId: snapshot.data.userId,
                    views: snapshot.data.views,
                    comments: snapshot.data.comments.length,
                    videoUrl: snapshot.data.path,
                    title: snapshot.data.title,
                    videoId: snapshot.data.id,
                    videoDurationInSeconds: snapshot.data.duration,
                    cartHeight: MediaQuery.of(context).size.height / 1.5,
                    isLanding: false,
                  ),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          translate(context, 'comments'),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (_) => PersonProfilePage(id: snapshot.data.comments[index].userId, name: snapshot.data.comments[index].userName)));
                            },
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: snapshot
                                              .data.comments[index].userImage ==
                                          null ||
                                      snapshot.data.comments[index].userImage ==
                                          ''
                                  ? AssetImage(
                                      'assets/images/avatar.png',
                                    )
                                  : CachedNetworkImageProvider(
                                      snapshot.data.comments[index].userImage,
                                    ),
                            ),
                            title: Text(
                                snapshot.data.comments[index].userName ?? ''),
                            subtitle: Text(
                                snapshot.data.comments[index].comment ?? ''),
                          );
                        },
                        itemCount: snapshot.data.comments.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AppUtils.userData?.imageUrl == null ||
                                              AppUtils.userData.imageUrl == ''
                                          ? AssetImage(
                                              'assets/images/avatar.png',
                                            )
                                          : CachedNetworkImageProvider(
                                              AppUtils.userData?.imageUrl,
                                            ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: TextFormField(
                                              controller: textEditingController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: translate(
                                                    context, 'add_comment'),
                                              ),
                                            ),
                                          ),
                                          flex: 5,
                                        ),
                                        addComment
                                            ? Expanded(
                                                flex: 1,
                                                child: Loader(
                                                  size: 20,
                                                ),
                                              )
                                            : Expanded(
                                                flex: 1,
                                                child: myButton2(
                                                  Icon(
                                                    Icons.send,
                                                    color: Colors.white,
                                                  ),
                                                  height: 52,
                                                  onTap: () async {
                                                    makeComment(
                                                        snapshot.data.id);
                                                  },
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
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void makeComment(int id) async {
    AppUtils.hideKeyboard(context);
    if (AppUtils.userData == null) {
      AppUtils.showNeedToRegisterDialog(context);
      return;
    }
    if (textEditingController.text.isEmpty) {
      return;
    }
    addComment = true;
    setState(() {});
    videoBloc.addComment(
      AddCommentToVideoRequest(
        user_id: AppUtils.userData.id,
        comment: textEditingController.text,
        video_id: id,
      ),
    );
    textEditingController.clear();
    addComment = false;
    setState(() {});

    // todo (issue) when adding a new comment after some cases the added comment does't appear
  }
}

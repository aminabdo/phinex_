import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phinex/Bles/Model/requests/chat/RoomPostRequest.dart';
import 'package:phinex/Bles/Model/responses/room/SingleRoomResponse.dart';
import 'package:phinex/Bles/bloc/social/RoomBloc.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;
import 'package:video_player/video_player.dart';

import '../attachment_view_page.dart';
import '../chats_app_bar.dart';
import 'single_group_settings_page.dart';

class PrivateGroupChatPage extends StatefulWidget {
  final int roomId;
  final String roomName;

  const PrivateGroupChatPage(
      {Key key, @required this.roomId, @required this.roomName})
      : super(key: key);

  // initPusher() async {
  //   await chatBloc.connect();
  //   await chatBloc.subscribe(roomId);
  //   await chatBloc.bind();
  // }
  //
  // disPusher() async {
  //   await chatBloc.unbind();
  //   await chatBloc.unsubscribe(roomId);
  //   await chatBloc.disconnect();
  // }

  @override
  _PrivateGroupChatPageState createState() => _PrivateGroupChatPageState();
}

class _PrivateGroupChatPageState extends State<PrivateGroupChatPage> {
  File imageFile;
  bool isShowSticker = false;

  String fileType;
  File file;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  int skip = 0;
  int take = 50;

  //
  // _PrivateGroupChatPageState() {
  //   widget.initPusher();
  // }

  // @override
  // dispose() {
  //   widget.disPusher();
  // }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      // roomBloc.getMessagesChat(BaseRequestSkipTake(
      //   id: widget.roomId,
      //   take: take,
      //   skip: skip + 10,
      // ));
    }
    if (listScrollController.offset <=
            listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {}
  }

  @override
  void initState() {
    super.initState();

    roomBloc.getSingleRoom(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: StreamBuilder<SingleRoomResponse>(
        stream: roomBloc.singleRoom.stream,
        builder: (context, snapshot) {
          if (roomBloc.loading.value) {
            return Loader();
          } else {
            var posts = snapshot.data.data.room.posts;
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                ChatsAppBar(
                  title: widget.roomName,
                  subtitle: '',
                  action: IconButton(
                    icon: Icon(
                      Icons.info_outlined,
                      color: deepBlueColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SingleGroupSettingsPage(
                              roomId: widget.roomId, name: widget.roomName),
                        ),
                      );
                    },
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    reverse: false,
                    controller: listScrollController,
                    physics: bouncingScrollPhysics,
                    itemBuilder: (context, index) {
                      // my messages
                      if (posts[posts.length - index - 1].userId.toString() ==
                          AppUtils.userData.id.toString()) {

                        // no content no attachment
                        if(posts[posts.length - index - 1].postBody == '' &&
                            posts[posts.length - index - 1].attachment == null) {

                          if(fileType != null) {
                            if(fileType == 'image') {
                              return myWidget(
                                Column(children: [
                                  buildTempImage(file),
                                  buildText(posts[posts.length - index - 1].postBody),
                                ],),
                                posts[posts.length - index - 1].createdAt,
                              );

                            } else {
                              return myWidget(
                                  Column(
                                    children: [
                                      buildTempVideo(file),
                                      buildText(posts[posts.length - index - 1].postBody),
                                    ],
                                  ),
                                  posts[posts.length - index - 1].createdAt
                              );
                            }
                          } else {
                            return SizedBox();
                          }

                          // no content has attachment
                        } if(posts[posts.length - index - 1].postBody != '' &&
                            posts[posts.length - index - 1].attachment == null) {

                          if(fileType != null) {
                            if(fileType == 'image') {
                              return myWidget(
                                Column(children: [
                                  buildTempImage(file),
                                  buildText(posts[posts.length - index - 1].postBody),
                                ],),
                                posts[posts.length - index - 1].createdAt,
                              );

                            } else {
                              return myWidget(
                                  Column(
                                    children: [
                                      buildTempVideo(file),
                                      buildText(posts[posts.length - index - 1].postBody),
                                    ],
                                  ),
                                  posts[posts.length - index - 1].createdAt
                              );
                            }
                          } else {
                            return SizedBox();
                          }
                        }

                        else if(posts[posts.length - index - 1].postBody == '' &&
                            posts[posts.length - index - 1].attachment != null){
                          if(posts[posts.length - index - 1].attachment.type == 'image') {
                            // image
                            return myWidget(
                              buildImage(posts[posts.length - index - 1].attachment.content),
                              posts[posts.length - index - 1].createdAt,
                            );

                          } else {
                            // video
                            return myWidget(
                              buildVideo(posts[posts.length - index - 1].attachment.content),
                              posts[posts.length - index - 1].createdAt,
                            );
                          }
                        }

                        // has content with image attachment
                        if(posts[posts.length - index - 1].postBody != '' &&
                            posts[posts.length - index - 1].attachment != null &&
                            posts[posts.length - index - 1].attachment.type == 'image'
                        ) {
                          return myWidget(
                            Column(
                              children: [
                                buildImage(posts[posts.length - index - 1].attachment.content),
                                buildText(posts[posts.length - index - 1].postBody)
                              ],
                            ),
                            posts[posts.length - index - 1].createdAt,);
                        }

                        // has content with video attachment
                        if(posts[posts.length - index - 1].postBody != '' &&
                            posts[posts.length - index - 1].attachment != null &&
                            posts[posts.length - index - 1].attachment.type == 'video'
                        ) {
                          return myWidget(
                            Column(
                              children: [
                                buildVideo(posts[posts.length - index - 1].attachment.content),
                                buildText(posts[posts.length - index - 1].postBody)
                              ],
                            ),
                            posts[posts.length - index - 1].createdAt,);
                        }

                        // has postBody no attachment
                        else {
                          return myWidget(
                            buildText(posts[posts.length - index - 1].postBody),
                            posts[posts.length - index - 1].createdAt,);
                        }
                      }
                      if (posts[posts.length - index - 1].userId == AppUtils.userData.id) {

                        // no postBody no attachment
                        if (posts[posts.length - index - 1].postBody == '' && posts[posts.length - index - 1].attachment == null) {
                          if (fileType != null) {
                            if (fileType == 'image') {
                              return myWidget(
                                buildTempImage(file),
                                posts[posts.length - index - 1].createdAt,
                              );
                            } else {
                              return myWidget(
                                buildTempVideo(file),
                                posts[posts.length - index - 1].createdAt,
                              );
                            }
                          } else {
                            return SizedBox();
                          }

                          // no postBody has attachment
                        } else if (posts[posts.length - index - 1].postBody == '' && posts[posts.length - index - 1].attachment != null) {
                          if (posts[posts.length - index - 1].attachment.type == 'image') {
                            // image
                            return myWidget(
                              buildImage(posts[posts.length - index - 1].attachment.content),
                              posts[posts.length - index - 1].createdAt,
                            );
                          } else {
                            // video
                            return myWidget(
                              buildVideo(posts[posts.length - index - 1].attachment.content),
                              posts[posts.length - index - 1].createdAt,
                            );
                          }
                          // has postBody no attachment
                        } else {
                          return myWidget(
                            buildText(posts[posts.length - index - 1].postBody),
                            posts[posts.length - index - 1].createdAt,
                          );
                        }
                      } else {

                        if (posts[posts.length - index - 1].postBody != '' && posts[posts.length - index - 1].attachment == null) {
                          return senderWidget(
                            buildText(posts[posts.length - index - 1].postBody),
                            posts[posts.length - index - 1].createdAt,
                          );
                        } else if (posts[posts.length - index - 1].attachment != null && posts[posts.length - index - 1].attachment.type == 'image') {
                          return senderWidget(
                            Column(
                              children: [
                                buildImage(posts[posts.length - index - 1].attachment.content),
                                buildText(posts[posts.length - index - 1].postBody ?? '')
                              ],
                            ),
                            posts[posts.length - index - 1].createdAt,
                          );
                        } else {
                          return senderWidget(
                            Column(
                              children: [
                                buildVideo(posts[posts.length - index - 1].attachment.content),
                                buildText(posts[posts.length - index - 1].postBody ?? '')
                              ],
                            ),
                            posts[posts.length - index - 1].createdAt,
                          );
                        }
                      }
                    },
                    itemCount: posts.length,
                  ),
                ),
                chatMessagesBox(),
                (isShowSticker ? buildSticker() : Container()),
              ],
            );
          }
        },
      ),
    );
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      setState(() {
        isShowSticker = false;
      });
    }
  }

  void getSticker() {
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  void onSendMessage(String content, int type) async {
    textEditingController.clear();
    setState(() {});
    // type: 0 = text, 1 = image
    if (content.trim() != '') {
      await roomBloc.addNewMessage(
        RoomPostRequest(
          attachment: null,
          postBody: content,
          postSenderId: AppUtils.userData.id,
          roomId: widget.roomId,
        ),
      );
      listScrollController.animateTo(
        listScrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
      setState(() {});
      listScrollController.animateTo(
        listScrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  Widget buildSticker() {
    return EmojiPicker(
      rows: 3,
      columns: 7,
      buttonMode: ButtonMode.MATERIAL,
      numRecommended: 10,
      onEmojiSelected: (emoji, category) {
        textEditingController.text += emoji.emoji;
      },
    );
  }

  Widget senderWidget(Widget child, String date) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Localizations.localeOf(context).languageCode == 'ar'
                      ? 0
                      : ScreenUtil().setWidth(10),
                  right: Localizations.localeOf(context).languageCode == 'ar'
                      ? ScreenUtil().setWidth(10)
                      : 0,
                  bottom: ScreenUtil().setHeight(8),
                ),
                child: GestureDetector(
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
              ),
              Expanded(
                child: Bubble(
                  nip: Localizations.localeOf(context).languageCode == 'ar'
                      ? BubbleNip.rightBottom
                      : BubbleNip.leftBottom,
                  nipWidth: 15,
                  nipHeight: 15,
                  margin: BubbleEdges.symmetric(
                    horizontal: ScreenUtil().setWidth(12),
                    vertical: ScreenUtil().setHeight(10),
                  ),
                  color: Color(0xffEAECF2),
                  child: child,
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(40),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Localizations.localeOf(context).languageCode == 'ar'
                  ? 0
                  : ScreenUtil().setWidth(60),
              right: Localizations.localeOf(context).languageCode == 'ar'
                  ? ScreenUtil().setWidth(60)
                  : 0,
            ),
            child: Text(
              timeAgo.format(DateTime.parse(date)),
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildText(String txt) {
    return Text(
      txt,
      style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
    );
  }

  Widget buildTempImage(File imageFile) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(imageFile),
        ),
      ),
    );
  }

  Widget buildImage(String imageUrl) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
        ),
      ),
    );
  }

  Widget buildTempVideo(File videoFile) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: 140,
      child: TempVideo(videoFile: videoFile),
    );
  }

  Widget buildVideo(String videoFile) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: 400,
      child: ChatVideo(videoFile: videoFile),
    );
  }

  Widget myWidget(Widget child, String date) {
    return Padding(
      padding: EdgeInsets.only(
        right: Localizations.localeOf(context).languageCode == 'ar'
            ? 0
            : ScreenUtil().setWidth(10),
        left: Localizations.localeOf(context).languageCode == 'ar'
            ? ScreenUtil().setWidth(10)
            : 0,
        bottom: ScreenUtil().setWidth(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(40),
              ),
              Expanded(
                child: Bubble(
                  nipWidth: 15,
                  nipHeight: 15,
                  nip: Localizations.localeOf(context).languageCode == 'ar'
                      ? BubbleNip.leftBottom
                      : BubbleNip.rightBottom,
                  margin: BubbleEdges.symmetric(
                    horizontal: ScreenUtil().setWidth(12),
                    vertical: ScreenUtil().setHeight(10),
                  ),
                  color: deepBlueColor,
                  child: child,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Localizations.localeOf(context).languageCode == 'ar'
                  ? 0
                  : ScreenUtil().setWidth(10),
              right: Localizations.localeOf(context).languageCode == 'ar'
                  ? ScreenUtil().setWidth(10)
                  : 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  timeAgo.format(DateTime.parse(date)),
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(6),
                ),
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 7,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatMessagesBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          ),
        ],
      ),
      height: ScreenUtil().setHeight(55),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(18),
          ),
          GestureDetector(
            onTap: () {
              pickFile();
            },
            child: Icon(
              FontAwesomeIcons.images,
              color: Colors.grey,
              size: 22,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(25),
          ),
          GestureDetector(
            onTap: () {
              getSticker();
            },
            child: Icon(
              FontAwesomeIcons.solidLaugh,
              color: Colors.grey,
              size: 22,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(18),
          ),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: 100,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    AppLocalization.of(context).translate('type_something'),
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(18),
          ),
          GestureDetector(
            onTap: () {
              onSendMessage(textEditingController.text, 0);
            },
            child: RotatedBox(
              quarterTurns:
                  Localizations.localeOf(context).languageCode == 'ar' ? 2 : 0,
              child: Icon(
                Icons.send_rounded,
                color: mainColor,
                size: 25,
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(15),
          ),
        ],
      ),
    );
  }

  void pickFile() async {
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * .3,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppUtils.translate(context, 'add_content'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppUtils.translate(context, 'cancel'),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: deepBlueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              ListTile(
                onTap: () async {
                  bool isGranted = await AppUtils.askCameraPermission();
                  if (isGranted) {
                    var pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    Navigator.pop(context);
                    if (pickedFile != null) {
                      // add file image to chat list
                      file = File(pickedFile.path);
                      fileType = 'image';
                      Map<String, dynamic> content = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => AttachmentViewPage(type: fileType, file: file),),);

                      if(content['send']) {
                        await roomBloc.addNewMessage(
                          RoomPostRequest(
                            roomId: widget.roomId,
                            postBody: content['text'] ?? "",
                            attachment: File(pickedFile.path),
                            postSenderId: AppUtils.userData.id,
                          ),
                        );

                        pickedFile = null;
                        listScrollController.animateTo(
                          0.0,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                        setState(() {});
                      }
                    } else {
                      // do nothing
                    }
                  } else {
                    AppUtils.showToast(msg: 'Accept Permission First');
                  }
                },
                leading: Icon(Icons.image, color: deepBlueColor),
                title: Text(
                  AppUtils.translate(context, 'gallery'),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () async {
                  bool isGranted = await AppUtils.askPhotosPermission();
                  if (isGranted) {
                    fileType = null;
                    file = null;
                    var pickedFile = await ImagePicker()
                        .getVideo(source: ImageSource.gallery);
                    Navigator.pop(context);
                    if (pickedFile != null) {
                      file = File(pickedFile.path);
                      fileType = 'video';
                      Map<String, dynamic> content = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              AttachmentViewPage(type: fileType, file: file),
                        ),
                      );

                     if(content['send']) {
                       await roomBloc.addNewMessage(
                         RoomPostRequest(
                           roomId: widget.roomId,
                           postBody: content['text'] ?? "",
                           attachment: File(pickedFile.path),
                           postSenderId: AppUtils.userData.id,
                         ),
                       );
                       pickedFile = null;
                       listScrollController.animateTo(
                         0.0,
                         duration: Duration(milliseconds: 200),
                         curve: Curves.easeOut,
                       );
                       setState(() {});
                     }
                    } else {
                      // do nothing
                    }
                  } else {
                    AppUtils.showToast(msg: 'Accept Permission First');
                  }
                },
                leading: Icon(
                  Icons.video_collection_sharp,
                  color: deepBlueColor,
                ),
                title: Text(
                  AppUtils.translate(context, 'video'),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TempVideo extends StatefulWidget {
  final File videoFile;

  const TempVideo({Key key, @required this.videoFile}) : super(key: key);

  @override
  _TempVideoState createState() => _TempVideoState();
}

class _TempVideoState extends State<TempVideo> {
  VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.file(
      widget.videoFile,
    );

    initializeVideoPlayer();
  }

  void initializeVideoPlayer() async {
    await videoPlayerController.initialize();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        allowedScreenSleep: false,
//        allowMuting: true,
        showControls: true,
//        allowPlaybackSpeedChanging: true,
        autoInitialize: true,
//        showControlsOnInitialize: true,
        placeholder: Loader(
          size: 50,
        ));

    setState(() {});
  }

  @override
  void dispose() {
    if (videoPlayerController != null) {
      videoPlayerController.dispose();
    }
    if (chewieController != null) {
      chewieController.dispose();
    }
    super.dispose();
  }

  ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    if (chewieController == null) {
      return Loader();
    } else {
      return FittedBox(child: Chewie(controller: chewieController));
    }
  }
}

class ChatVideo extends StatefulWidget {
  final String videoFile;

  const ChatVideo({Key key, @required this.videoFile}) : super(key: key);

  @override
  _ChatVideoState createState() => _ChatVideoState();
}

class _ChatVideoState extends State<ChatVideo> {
  VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(
      widget.videoFile,
    );

    initializeVideoPlayer();
  }

  void initializeVideoPlayer() async {
    await videoPlayerController.initialize();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        allowedScreenSleep: false,
        showControls: true,
        autoInitialize: true,
        placeholder: Loader());

    setState(() {});
  }

  @override
  void dispose() {
    if (videoPlayerController != null) {
      videoPlayerController.dispose();
    }
    if (chewieController != null) {
      chewieController.dispose();
    }
    super.dispose();
  }

  ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    if (chewieController == null) {
      return Loader(
        size: 40,
      );
    } else {
      return FittedBox(
        child: Chewie(
          controller: chewieController,
        ),
        fit: BoxFit.fill,
      );
    }
  }
}

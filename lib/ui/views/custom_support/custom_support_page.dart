import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/chat/NewMessageRequest.dart';
import 'package:phinex/Bles/Model/responses/chat/IntiateNewChatResponse.dart';
import 'package:phinex/Bles/bloc/admin_chat/AdminChatBloc.dart';
import 'package:phinex/ui/views/chats/attachment_view_page.dart';
import 'package:phinex/ui/views/chats/chats_app_bar.dart';
import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;
import 'package:bubble/bubble.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:video_player/video_player.dart';

class CustomSupportChatPage extends StatefulWidget {
  static final int pageIndex = 0;
  final int id;

  CustomSupportChatPage({Key key, @required this.id}) : super(key: key);

  disPusher() async {
    await adminChatBloc.unbind();
    await adminChatBloc.unsubscribe(id);
    await adminChatBloc.disconnect();
  }

  @override
  _CustomSupportChatPageState createState() => _CustomSupportChatPageState();
}

class _CustomSupportChatPageState extends State<CustomSupportChatPage> {
  String fileType;
  File file;

  bool isShowSticker = false;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  int skip = 0;
  int take = 50;

  @override
  dispose() {
    widget.disPusher();
    super.dispose();
  }

  _scrollListener() async {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      if (adminChatBloc.subLoading.value == true) {
        return;
      }

      adminChatBloc.getMessagesChat(BaseRequestSkipTake(
        id: widget.id,
        take: take,
        skip: skip += 50,
      ));
    }
    if (listScrollController.offset <=
            listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print('>>>>> in the bottom');
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.id == null || widget.id == 0) {
    } else {
      adminChatBloc.getMessagesChat(BaseRequestSkipTake(
        id: widget.id,
        take: take,
        skip: skip,
      ));
    }

    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);

    isShowSticker = false;
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

  void onSendMessage(String content) async {
    textEditingController.clear();
    setState(() {});
    // type: 0 = text, 1 = image
    if (content.trim() != '') {
      await adminChatBloc.addNewMessage(
        NewMessageRequest(
          chat_id: widget.id,
          content: content,
          user_id: AppUtils.userData.id,
        ),
      );
      listScrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 2100),
        curve: Curves.easeOut,
      );
      setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          if (isShowSticker) {
            setState(() {
              isShowSticker = false;
            });
          } else {
            AppUtils.hideKeyboard(context);
            Navigator.pop(context);
          }

          return false;
        },
        child: StreamBuilder<Chat>(
          stream: adminChatBloc.chat.stream,
          builder: (context, snapshot) {
            if (adminChatBloc.loading.value) {
              return Loader();
            } else {
              print("adminChatBloc.chat.stream");
              print(adminChatBloc.chat.value);
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  ChatsAppBar(
                    title: AppUtils.translate(context, 'custom_support'),
                    subtitle: '',
                  ),
                  Flexible(
                    child: ListView.builder(
                      controller: listScrollController,
                      reverse: true,
                      physics: bouncingScrollPhysics,
                      itemBuilder: (context, index) {
                        // my messages
                        if (snapshot
                                .data
                                .messages[
                                    snapshot.data.messages.length - index - 1]
                                .userId
                                .toString() ==
                            AppUtils.userData.id.toString()) {
                          // no content no attachment
                          if (snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content ==
                                  '' &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment ==
                                  null) {
                            if (fileType != null) {
                              if (fileType == 'image') {
                                return myWidget(
                                  Column(
                                    children: [
                                      buildTempImage(file),
                                      buildText(snapshot
                                          .data
                                          .messages[
                                              snapshot.data.messages.length -
                                                  index -
                                                  1]
                                          .content),
                                    ],
                                  ),
                                  snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .createdAt,
                                );
                              } else {
                                return myWidget(
                                    Column(
                                      children: [
                                        buildTempVideo(file),
                                        buildText(snapshot
                                            .data
                                            .messages[
                                                snapshot.data.messages.length -
                                                    index -
                                                    1]
                                            .content),
                                      ],
                                    ),
                                    snapshot
                                        .data
                                        .messages[
                                            snapshot.data.messages.length -
                                                index -
                                                1]
                                        .createdAt);
                              }
                            } else {
                              return SizedBox();
                            }

                            // no content has attachment
                          } else if (snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content ==
                                  '' &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment !=
                                  null) {
                            if (snapshot
                                    .data
                                    .messages[snapshot.data.messages.length -
                                        index -
                                        1]
                                    .attachment
                                    .type ==
                                'image') {
                              // image
                              return myWidget(
                                buildImage(snapshot
                                    .data
                                    .messages[snapshot.data.messages.length -
                                        index -
                                        1]
                                    .attachment
                                    .content),
                                snapshot
                                    .data
                                    .messages[snapshot.data.messages.length -
                                        index -
                                        1]
                                    .createdAt,
                              );
                            } else {
                              // video
                              return myWidget(
                                buildVideo(snapshot
                                    .data
                                    .messages[snapshot.data.messages.length -
                                        index -
                                        1]
                                    .attachment
                                    .content),
                                snapshot
                                    .data
                                    .messages[snapshot.data.messages.length -
                                        index -
                                        1]
                                    .createdAt,
                              );
                            }
                          }

                          // has content with image attachment
                          if (snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content !=
                                  '' &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment !=
                                  null &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment
                                      .type ==
                                  'image') {
                            return myWidget(
                              Column(
                                children: [
                                  buildImage(snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment
                                      .content),
                                  buildText(snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content)
                                ],
                              ),
                              snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .createdAt,
                            );
                          }

                          // has content with video attachment
                          if (snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content !=
                                  '' &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment !=
                                  null &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment
                                      .type ==
                                  'video') {
                            return myWidget(
                              Column(
                                children: [
                                  buildVideo(snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment
                                      .content),
                                  buildText(snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content)
                                ],
                              ),
                              snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .createdAt,
                            );
                          }

                          // has content no attachment
                          else {
                            return myWidget(
                              buildText(snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .content),
                              snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .createdAt,
                            );
                          }
                        }

                        // the sender messages  ===============================================================================
                        else {
                          if (snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content !=
                                  '' &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment ==
                                  null) {
                            return senderWidget(
                              buildText(snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .content),
                              snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .createdAt,

                            );
                          } else if (snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content !=
                                  '' &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment !=
                                  null &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment
                                      .type ==
                                  'image') {
                            return senderWidget(
                              Column(
                                children: [
                                  buildImage(snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment
                                      .content),
                                  buildText(snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content),
                                ],
                              ),
                              snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .createdAt,
                            );
                          } else if (snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content !=
                                  '' &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment !=
                                  null &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment
                                      .type ==
                                  'video') {
                            return senderWidget(
                              Column(
                                children: [
                                  buildVideo(snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment
                                      .content),
                                  buildText(snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .content),
                                ],
                              ),
                              snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .createdAt,
                            );
                          } else if (snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment !=
                                  null &&
                              snapshot
                                      .data
                                      .messages[snapshot.data.messages.length -
                                          index -
                                          1]
                                      .attachment
                                      .type ==
                                  'image') {
                            return senderWidget(
                              buildImage(snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .attachment
                                  .content),
                              snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .createdAt,
                            );
                          } else {
                            return senderWidget(
                              buildVideo(snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .attachment
                                  .content),
                              snapshot
                                  .data
                                  .messages[
                                      snapshot.data.messages.length - index - 1]
                                  .createdAt,
                            );
                          }
                        }
                      },
                      itemCount: snapshot.data.messages.length,
                    ),
                  ),
                  chatMessagesBox(),
                  (isShowSticker ? buildSticker() : Container()),
                ],
              );
            }
          },
        ),
      ),
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
              onSendMessage(textEditingController.text);
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
                    var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                    Navigator.pop(context);
                    if (pickedFile != null) {
                      // add file image to chat list
                      file = File(pickedFile.path);
                      fileType = 'image';
                      Map<String, dynamic> content = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AttachmentViewPage(type: fileType, file: file),
                        ),
                      );

                      if(content['send']) {
                        await adminChatBloc.addNewMessage(
                          NewMessageRequest(
                            chat_id: widget.id,
                            content: content['text'] ?? "",
                            attachment: File(pickedFile.path),
                            user_id: AppUtils.userData.id,
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
                       await adminChatBloc.addNewMessage(
                         NewMessageRequest(
                           chat_id: widget.id,
                           content: content['text'] ?? "",
                           attachment: File(pickedFile.path),
                           user_id: AppUtils.userData.id,
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

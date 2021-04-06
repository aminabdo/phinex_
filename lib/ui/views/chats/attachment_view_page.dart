import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:video_player/video_player.dart';

class AttachmentViewPage extends StatefulWidget {
  final String type;
  final File file;

  const AttachmentViewPage({
    Key key,
    @required this.type,
    @required this.file,
  }) : super(key: key);

  @override
  _AttachmentViewPageState createState() => _AttachmentViewPageState();
}

class _AttachmentViewPageState extends State<AttachmentViewPage> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(AppUtils.translate(context, 'chats'), context, onBackBtnClicked: () {
        Navigator.pop(context, {"text": textEditingController.text, "send": false});
      }),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(child: widget.type == 'image' ? Image.file(widget.file) : TempVideo(videoFile: widget.file)),
            chatMessagesBox(),
          ],
        ),
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
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: textEditingController,
              keyboardType: TextInputType.multiline,
              maxLines: 100,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppLocalization.of(context).translate('type_something'),
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
              Navigator.pop(context, {"text": textEditingController.text, "send": true});
            },
            child: RotatedBox(
              quarterTurns: Localizations.localeOf(context).languageCode == 'ar' ? 2 : 0,
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
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/videos/UploadNewVideo.dart';
import 'package:phinex/Bles/bloc/video/VideoBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:video_player/video_player.dart';

class AddEditVideoPage extends StatefulWidget {
  final String state;
  final int videoId;

  const AddEditVideoPage(
      {Key key, @required this.state, @required this.videoId})
      : super(key: key);

  @override
  _AddEditVideoPageState createState() => _AddEditVideoPageState();
}

class _AddEditVideoPageState extends State<AddEditVideoPage> {
  File videoFile;
  bool isUploading = false;

  VideoPlayerController _controller;
  ChewieController chewieController;
  String titleErrorMsg;
  String descriptionErrorMsg;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> initializeVideoPlayer() async {
    await _controller.initialize();
    chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: false,
        looping: false,
        allowedScreenSleep: false,
        showControls: true,
        autoInitialize: true,
        placeholder: Loader(
          size: 50,
        ));

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    if (widget.state == 'edit') {
      var currentVideo = videoBloc.landing.value.videos
          .firstWhere((element) => element.id == widget.videoId);
      titleController.text = currentVideo.title;
      descriptionController.text = currentVideo.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        translate(
            context, widget.state == 'add' ? 'add_new_video' : 'edit_video'),
        context,
      ),
      body: LoadingOverlay(
        isLoading: isUploading,
        opacity: .5,
        progressIndicator: Loader(),
        color: Colors.white,
        child: SingleChildScrollView(
          physics: bouncingScrollPhysics,
          child: Column(
            children: [
              widget.state == 'add'
                  ? GestureDetector(
                      onTap: () async {
                        bool permissionIsGranted =
                            await AppUtils.askPhotosPermission();
                        if (permissionIsGranted) {
                          var pickedFile = await ImagePicker.pickVideo(
                            source: ImageSource.gallery,
                            maxDuration: Duration(seconds: 30),
                          );
                          if (pickedFile != null) {
                            videoFile = pickedFile;
                            _controller = VideoPlayerController.file(
                              videoFile,
                            );
                            await initializeVideoPlayer();
                            setState(() {});
                          }
                        } else {
                          AppUtils.showToast(msg: 'Accept Permission First');
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(320),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.grey,
                        )),
                        child: videoFile == null
                            ? Center(
                                child: Icon(
                                  Icons.video_call,
                                  color: deepBlueColor,
                                  size: 100,
                                ),
                              )
                            : _controller.value.initialized
                                ? Stack(
                                    children: [
                                      Chewie(
                                        controller: chewieController,
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            videoFile = null;
                                            setState(() {});
                                          })
                                    ],
                                  )
                                : Loader(),
                      ),
                    )
                  : SizedBox.shrink(),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    MyTextFormField(
                      title: translate(context, 'title'),
                      errorMessage: titleErrorMsg,
                      controller: titleController,
                    ),
                    MyTextFormField(
                      title: translate(context, 'description'),
                      maxLines: 5,
                      errorMessage: descriptionErrorMsg,
                      controller: descriptionController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    myButton(translate(context, 'submit'), onTap: () {
                      uploadVideo();
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void uploadVideo() async {
    if (titleController.text.isEmpty) {
      titleErrorMsg = translate(context, 'required');
    } else {
      titleErrorMsg = null;
    }

    if (descriptionController.text.isEmpty) {
      descriptionErrorMsg = translate(context, 'required');
    } else {
      descriptionErrorMsg = null;
    }

    setState(() {});

    if (widget.state == 'add') {
      if (videoFile == null) {
        AppUtils.showToast(msg: translate(context, 'choose_a_video'));
        return;
      } else if (_controller.value.duration > Duration(seconds: 30)) {
        AppUtils.showToast(
            msg: AppUtils.translate(context, 'video_duration_msg'));
        return;
      }
    }

    if (widget.state == 'add') {
      if (titleErrorMsg == null && descriptionErrorMsg == null && videoFile != null && _controller.value.duration <= Duration(seconds: 30)) {
        isUploading = true;
        setState(() {});
        await videoBloc.uploadVideo(
          UploadNewVideoRequest(
            titleController.text,
            descriptionController.text,
            AppUtils.userData.id.toString(),
            videoFile,
          ),
        );

        clear();
      }
    } else {
      if (titleErrorMsg == null && descriptionErrorMsg == null) {
        isUploading = true;
        setState(() {});

        await videoBloc.editVideo(
          UploadNewVideoRequest(
            titleController.text,
            descriptionController.text,
            null,
            null,
          ),
          widget.videoId,
        );

        clear();
      }
    }
  }

  void clear() {
    videoFile = null;
    titleController.clear();
    descriptionController.clear();
    isUploading = false;
    setState(() {});
    Navigator.pop(context);
    videoBloc.getLanding(
        BaseRequestSkipTake(id: AppUtils.userData.id, take: 10, skip: 0));
    AppUtils.showToast(msg: 'Done', bgColor: mainColor);
  }
}

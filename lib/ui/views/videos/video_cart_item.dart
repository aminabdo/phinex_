import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numeral/numeral.dart';
import 'package:phinex/Bles/bloc/video/VideoBloc.dart';
import 'package:phinex/ui/views/videos/add_edit_video_page.dart';
import 'package:phinex/ui/views/videos/single_video_page.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:video_player/video_player.dart';

class VideoCardItem extends StatefulWidget {
  final String videoUrl;
  final String title;
  final int views;
  final int comments;
  final int videoId;
  final int userId;
  final num videoDurationInSeconds;
  final double cartHeight;
  final bool isLanding;

  const VideoCardItem({
    Key key,
    @required this.videoUrl,
    @required this.title,
    @required this.views,
    @required this.comments,
    @required this.videoId,
    @required this.userId,
    this.cartHeight,
    @required this.videoDurationInSeconds, @required this.isLanding
  }) : super(key: key);

  @override
  _VideoCardItemState createState() => _VideoCardItemState();
}

class _VideoCardItemState extends State<VideoCardItem> {
  VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(
      widget.videoUrl,
    );
    initializeVideoPlayer();
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

  showVideoOptions(int videoId) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * .3,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 30,
                    height: 10,
                  ),
                  Text(
                    translate(context, 'video_settings'),
                    style: TextStyle(color: deepBlueColor, fontSize: 20),
                  ),
                  GestureDetector(
                    child: Text(
                      translate(context, 'cancel'),
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddEditVideoPage(
                        state: 'edit',
                        videoId: widget.videoId,
                      ),
                    ),
                  );
                },
                title: Text(
                  translate(context, 'edit_video'),
                  style: TextStyle(color: deepBlueColor),
                ),
                leading: Icon(
                  FontAwesomeIcons.edit,
                  color: deepBlueColor,
                  size: 20,
                ),
              ),
              ListTile(
                onTap: () async {
                  Navigator.pop(context);
                  videoBloc.deleteVideo(videoId);
                  videoBloc.landing.value.videos.removeAt(
                    videoBloc.landing.value.videos.indexWhere(
                      (element) => element.id == videoId,
                    ),
                  );

                  setState(() {});
                },
                title: Text(
                  translate(context, 'delete_video'),
                  style: TextStyle(color: Colors.red),
                ),
                leading: Icon(
                  FontAwesomeIcons.edit,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Column(
          children: [
            Expanded(
              child: chewieController == null
                  ? Loader()
                  : Stack(
                      children: [
                        Chewie(
                          controller: chewieController,
                        ),
                        widget.userId == AppUtils.userData?.id
                            ? Positioned(
                                top: 15,
                                right: 15,
                                child: GestureDetector(
                                  onTap: () {
                                    showVideoOptions(widget.videoId);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.black38,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            if(!widget.isLanding)
              if(AppUtils.userData != null)
                ListTile(
                  title: Text(
                      AppUtils.userData?.firstName ?? '' + ' ' + AppUtils.userData?.lastName,
                  ),
                  subtitle: Text(AppUtils.userData.phone),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: AppUtils.userData?.imageUrl == null ||
                        AppUtils.userData?.imageUrl == ''
                        ? AssetImage(
                      'assets/images/avatar.png',
                    )
                        : CachedNetworkImageProvider(
                      AppUtils.userData?.imageUrl,
                    ),
                  ),
                  // trailing: myButton2(
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           FontAwesomeIcons.solidThumbsUp,
                  //           color: Colors.white,
                  //           size: 18,
                  //         ),
                  //         SizedBox(
                  //           width: 8,
                  //         ),
                  //         Text(
                  //           'Like',
                  //           style: TextStyle(color: Colors.white),
                  //         )
                  //       ],
                  //     ),
                  //     onTap: () {},
                  //     btnColor: greenColor,
                  //     width: MediaQuery.of(context).size.width / 4),
                ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SingleVideoPage(videoId: widget.videoId),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              color: Colors.grey,
                              size: 18,
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(8),
                            ),
                            Text(
                              Numeral(widget.views).value(),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.comments,
                              color: Colors.grey,
                              size: 18,
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(8),
                            ),
                            Text(
                                Numeral(widget.comments ?? 0).value(),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      width: double.infinity,
      height: widget.cartHeight ?? MediaQuery.of(context).size.height / 1.5,
    );
  }

  void initializeVideoPlayer() async {
    await videoPlayerController.initialize();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        allowedScreenSleep: false,
        showControls: true,
//        allowPlaybackSpeedChanging: true,
        autoInitialize: true,
//        showControlsOnInitialize: true,
        placeholder: Loader(
          size: 50,
        ));

    setState(() {});
  }
}

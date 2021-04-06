import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/video/VideoLandingResponse.dart';
import 'package:phinex/Bles/bloc/video/VideoBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/views/videos/add_edit_video_page.dart';
import 'package:phinex/ui/views/videos/video_cart_item.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class VideosPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  List<String> categories = [];
  int selectedOption = 0;

  bool loadMore = false;
  ScrollController _scrollController = ScrollController();
  int skip = 0;
  int take = 10;
  int skipMy = 0;
  int takeMy = 10;

  @override
  void initState() {
    super.initState();
    videoBloc.getLanding(
      BaseRequestSkipTake(
        skip: skip,
        take: take,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (AppUtils.userData == null) {
      categories = [
        translate(context, 'popular_videos'),
      ];
    } else {
      categories = [
        translate(context, 'popular_videos'),
        translate(context, 'my_videos'),
      ];
    }

    return Scaffold(
      appBar: myAppBar(
        translate(context, 'funny_videos'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
        },
        actions: AppUtils.userData == null ? []
            : [
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AddEditVideoPage(
                          videoId: null,
                          state: 'add',
                        ),
                      ),
                    );
                  },
                ),
              ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
          return false;
        },
        child: StreamBuilder<VideoLandingResponse>(
          stream: videoBloc.landing.stream,
          builder: (context, snapshot) {
            if (videoBloc.loading.value) {
              return Loader();
            } else {
              _scrollController
                ..addListener(
                  () {
                    if (_scrollController.position.pixels ==
                        _scrollController.position.maxScrollExtent) {
                      if(selectedOption == 0) {
                        skip += 10;
                        take += 10;
                        videoBloc.getLanding(
                          BaseRequestSkipTake(
                            skip: skip,
                            take: take,
                          ),
                        );
                      } else if(selectedOption == 1) {
                        skipMy += 10;
                        takeMy += 10;
                        videoBloc.getLanding(
                          BaseRequestSkipTake(
                            skip: skipMy,
                            take: takeMy,
                          ),
                        );
                      }
                    }
                  },
                );
              if (snapshot.hasData && snapshot.data != null) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  physics: bouncingScrollPhysics,
                  child: Column(
                    children: [
                      Material(
                        elevation: 5,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(12),
                            top: ScreenUtil().setHeight(10),
                            bottom: ScreenUtil().setHeight(10),
                          ),
                          height: ScreenUtil().setHeight(80),
                          width: double.infinity,
                          child: ListView(
                            physics: bouncingScrollPhysics,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                              categories.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectedOption = index;
                                    setState(() {});

                                    if (selectedOption == 0) {
                                      skip = 0;
                                      take = 10;
                                      videoBloc.getLanding(
                                        BaseRequestSkipTake(
                                          skip: skip,
                                          take: take,
                                        ),
                                      );
                                    }
                                    if (selectedOption == 1) {
                                      skipMy = 0;
                                      takeMy = 10;
                                      videoBloc.getLanding(
                                        BaseRequestSkipTake(
                                          skip: skipMy,
                                          take: takeMy,
                                          id: AppUtils.userData.id,
                                        ),
                                      );
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: selectedOption == index
                                          ? mainColor.withOpacity(.1)
                                          : Colors.white,
                                      border: Border.all(
                                        color: selectedOption == index
                                            ? mainColor
                                            : Colors.grey[300],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(categories[index]),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.videos.length,
                        itemBuilder: (context, index) {
                          return VideoCardItem(
                            title: snapshot.data.videos[index].title,
                            videoUrl: snapshot.data.videos[index].path,
                            videoId: snapshot.data.videos[index].id,
                            comments: snapshot.data.videos[index].commentsCount,
                            views: snapshot.data.videos[index].views,
                            userId: snapshot.data.videos[index].userId,
                            videoDurationInSeconds: snapshot.data.videos[index].duration,
                            isLanding: true,
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return Loader();
            }
          },
        ),
      ),
    );
  }
}

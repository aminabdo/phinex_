import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/videos/AddCommentToVideoRequest.dart';
import 'package:phinex/Bles/Model/requests/videos/UploadNewVideo.dart';
import 'package:phinex/Bles/Model/responses/video/SingleVideoResponse.dart';
import 'package:phinex/Bles/Model/responses/video/VideoComments.dart';
import 'package:phinex/Bles/Model/responses/video/VideoLandingResponse.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';

class VideoBloc extends BaseBloc {
  BehaviorSubject<VideoLandingResponse> _landing =
      BehaviorSubject<VideoLandingResponse>();
  BehaviorSubject<SingleVideoResponse> _single =
      BehaviorSubject<SingleVideoResponse>();

  void updateUI() {
    _landing.value = _landing.value;
    _single.value = _single.value;
  }

  getLanding(BaseRequestSkipTake request) async {
    loading.value = true;

    VideoLandingResponse response;
    if (request.id == null) {
      if (request.skip == 0) {
        response = VideoLandingResponse.fromMap(
          await (await repository.get(ApiRoutes.getVideos(request))).data,
        );
      } else {
        response.videos.addAll(VideoLandingResponse.fromMap(
          await (await repository.get(ApiRoutes.getVideos(request))).data,
        ).videos);
      }
    } else {
      response = VideoLandingResponse.fromMap(await (await repository.get(ApiRoutes.getUserVideos(request))).data,
      );
    }
    _landing.value = response;
    loading.value = false;
  }

  getSingle(int videoId) async {
    loading.value = true;
    SingleVideoResponse response = SingleVideoResponse.fromMap(await (await repository.get(ApiRoutes.getSingleVideo(videoId))).data);
    _single.value = response;
    loading.value = false;
  }

  Future<Response> addComment(AddCommentToVideoRequest request) async {
    if (request.parent_id == 0) {
      _single.value.comments.add(CommentsBean(
          userId: request.user_id,
          comment: request.comment,
          userImage: AppUtils.userData.imageUrl,
          userName: AppUtils.userData.username,
          parentId: request.parent_id,
      ),
      );
      _single.value = _single.value;

      CommentsBean comment = CommentsBean.fromMap((await repository.post(ApiRoutes.addCommentToVideo(), request.toJson())).data,
      );
      // _single.value.comments.indexWhere((element) => (element.))
    } else {
      ChildBean child = ChildBean.fromMap((await repository.post(ApiRoutes.addCommentToVideo(), request.toJson())).data);
      _single.value.comments[request.parent_id].child.add(child);
    }

    _landing.value.videos.firstWhere((element) => element.id == request.video_id).commentsCount++;

    updateUI();
  }

  Future<Response> deleteVideo(int videoId) async {
    await repository.delete(ApiRoutes.deleteVideo(videoId));
    _landing.value.videos.removeWhere((element) => element.id == videoId);
    updateUI();
  }

  Future<Video> uploadVideo(UploadNewVideoRequest request) async {
    Video video = Video.fromMap((await repository.postUpload(ApiRoutes.addNewVideo(), await request.toUpload())).data);
    _landing.value.videos.add(video);
    _landing = _landing;
    updateUI();
    return video;
  }

  getVideoComments(BaseRequestSkipTake request) async {
    if (request.skip == 0) {
      VideoComments comments = VideoComments.fromJson(await (await repository.get(ApiRoutes.getVideoComments(request))).data);
      _single.value.comments.clear();
      _single.value.comments.addAll(comments.data);
    } else {
      VideoComments comments = VideoComments.fromJson(await (await repository.get(ApiRoutes.getVideoComments(request))).data);
      _single.value.comments.addAll(comments.data);
    }

    updateUI();
  }

  Future<Response> editVideo(UploadNewVideoRequest request, int videoID) async {
    Video video = Video.fromMap((await repository.patch(ApiRoutes.editVideo(videoID), request.toJson())).data);
    _landing.value.videos.add(video);
    _landing = _landing;
    return response.value;
  }

  dispose() {
    _landing.close();
    _single.close();
  }

  clear() {
    _landing = BehaviorSubject<VideoLandingResponse>();
    _single = BehaviorSubject<SingleVideoResponse>();
  }

  BehaviorSubject<VideoLandingResponse> get landing => _landing;

  BehaviorSubject<SingleVideoResponse> get single => _single;
}

final videoBloc = VideoBloc();

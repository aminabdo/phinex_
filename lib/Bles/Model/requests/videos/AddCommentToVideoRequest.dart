class AddCommentToVideoRequest {
  int video_id;
  int user_id;
  String comment;
  int parent_id;

  AddCommentToVideoRequest({this.video_id, this.user_id, this.comment, this.parent_id = 0});

  Map toJson() {
    return {
      'video_id': this.video_id,
      'user_id': this.user_id,
      'comment': this.comment,
      'parent_id': this.parent_id,
    };
  }

  @override
  String toString() {
    return 'AddCommentToVideo{video_id: $video_id, user_id: $user_id, comment: $comment, parent_id: $parent_id}';
  }
}

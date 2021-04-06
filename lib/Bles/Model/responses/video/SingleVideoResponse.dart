class SingleVideoResponse {
  int id;
  int userId;
  String status;
  String title;
  String description;
  int views;
  num duration;
  String path;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  List<CommentsBean> comments;

  static SingleVideoResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SingleVideoResponse singleVideoResponseBean = SingleVideoResponse();
    singleVideoResponseBean.id = map['id'];
    singleVideoResponseBean.userId = map['user_id'];
    singleVideoResponseBean.status = map['status'];
    singleVideoResponseBean.title = map['title'];
    singleVideoResponseBean.description = map['description'];
    singleVideoResponseBean.views = map['views'];
    singleVideoResponseBean.duration = map['duration'];
    singleVideoResponseBean.path = map['path'];
    singleVideoResponseBean.deletedAt = map['deleted_at'];
    singleVideoResponseBean.createdAt = map['created_at'];
    singleVideoResponseBean.updatedAt = map['updated_at'];
    singleVideoResponseBean.comments = List()..addAll(
      (map['comments'] as List ?? []).map((o) => CommentsBean.fromMap(o))
    );
    return singleVideoResponseBean;
  }

  Map toJson() => {
    "id": id,
    "user_id": userId,
    "status": status,
    "title": title,
    "description": description,
    "views": views,
    "duration": duration,
    "path": path,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "comments": comments,
  };
}

class CommentsBean {

  int id;
  int videoId;
  int userId;
  int parentId;
  String status;
  String comment;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  List<ChildBean> child;
  String userName;
  dynamic userImage;


  CommentsBean(
      {this.id,
      this.videoId,
      this.userId,
      this.parentId,
      this.status,
      this.comment,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.child,
      this.userName,
      this.userImage});

  static CommentsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CommentsBean commentsBean = CommentsBean();
    commentsBean.id = map['id'];
    commentsBean.videoId = map['video_id'];
    commentsBean.userId = map['user_id'];
    commentsBean.parentId = map['parent_id'];
    commentsBean.status = map['status'];
    commentsBean.comment = map['comment'];
    commentsBean.deletedAt = map['deleted_at'];
    commentsBean.createdAt = map['created_at'];
    commentsBean.updatedAt = map['updated_at'];
    commentsBean.child = List()..addAll(
      (map['child'] as List ?? []).map((o) => ChildBean.fromMap(o))
    );
    commentsBean.userName = map['user_name'];
    commentsBean.userImage = map['user_image'];
    return commentsBean;
  }

  Map toJson() => {
    "id": id,
    "video_id": videoId,
    "user_id": userId,
    "parent_id": parentId,
    "status": status,
    "comment": comment,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "child": child,
    "user_name": userName,
    "user_image": userImage,
  };
}

class ChildBean {
  int id;
  int videoId;
  int userId;
  int parentId;
  String status;
  String comment;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String userName;

  static ChildBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChildBean childBean = ChildBean();
    childBean.id = map['id'];
    childBean.videoId = map['video_id'];
    childBean.userId = map['user_id'];
    childBean.parentId = map['parent_id'];
    childBean.status = map['status'];
    childBean.comment = map['comment'];
    childBean.deletedAt = map['deleted_at'];
    childBean.createdAt = map['created_at'];
    childBean.updatedAt = map['updated_at'];
    childBean.userName = map['user_name'];
    return childBean;
  }

  Map toJson() => {
    "id": id,
    "video_id": videoId,
    "user_id": userId,
    "parent_id": parentId,
    "status": status,
    "comment": comment,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user_name": userName,
  };
}
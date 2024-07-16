class RealModel {
  int? id;
  int? roomId;
  String? video;
  String? preview;
  String? size;
  String? duration;
  int? likesCount;
  String? likesCountTranslated;
  bool? authLikeStatus;

  RealModel(
      {this.id,
        this.roomId,
        this.video,
        this.preview,
        this.size,
        this.duration,
        this.likesCount,
        this.likesCountTranslated,
        this.authLikeStatus});

  RealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    video = json['video'];
    preview = json['preview'];
    size = json['size'];
    duration = json['duration'];
    likesCount = json['likes_count'];
    likesCountTranslated = json['likes_count_translated'];
    authLikeStatus = json['auth_like_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['room_id'] = roomId;
    data['video'] = video;
    data['preview'] = preview;
    data['size'] = size;
    data['duration'] = duration;
    data['likes_count'] = likesCount;
    data['likes_count_translated'] = likesCountTranslated;
    data['auth_like_status'] = authLikeStatus;
    return data;
  }
}
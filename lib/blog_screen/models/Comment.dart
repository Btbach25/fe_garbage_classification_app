class Comment {
  String? content;
  int? author;
  String? authorName;
  String? authorAvatar;
  String? createdAt;
  String? updatedAt;
  int? react;
  int? id;
  int? likeCount;
  int? dislikeCount;

  Comment(
    {
      this.content,
      this.author,
      this.authorAvatar,
      this.authorName,
      this.createdAt,
      this.updatedAt,
      this.react,
      this.id,
      this.likeCount,
      this.dislikeCount
    });

  Comment.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    author = json['author'];
    authorName = json['author_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    react = json['react'];
    id = json['id'];
    likeCount = json['like_count'];
    dislikeCount = json['dislike_count'];
    authorAvatar = json['author_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['author'] = this.author;
    data['author_name'] = this.authorName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['react'] = this.react;
    data['id'] = this.id;
    data['like_count'] = this.likeCount;
    data['dislike_count'] = this.dislikeCount;
    data['author_avatar'] = this.authorAvatar;
    return data;
  }
}
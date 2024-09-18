class Post {
  String? title;
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
  int? comments;
  int? react_id;
  Post(
      {this.title,
      this.content,
      this.author,
      this.authorName,
      this.createdAt,
      this.updatedAt,
      this.react,
      this.id,
      this.likeCount,
      this.dislikeCount,
      this.comments,
      this.react_id,
      this.authorAvatar});

  Post.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    content = json['content'] as String;
    author = json['author'] ;
    authorName = json['author_name'] as String;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    react = json['react'];
    id = json['id'];
    likeCount = json['like_count'];
    dislikeCount = json['dislike_count'];
    comments = json['comments'];
    react_id = json['react_id'];
    authorAvatar = json['author_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['author'] = this.author;
    data['author_name'] = this.authorName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['react'] = this.react;
    data['id'] = this.id;
    data['like_count'] = this.likeCount;
    data['dislike_count'] = this.dislikeCount;
    data['comments'] = this.comments;
    data['react_id'] = this.react_id;
    data['author_avatar'] = this.authorAvatar;
    return data;
  }
}
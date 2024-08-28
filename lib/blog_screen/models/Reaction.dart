class Reaction {
  int? id;
  String? authorName;
  int? reactionType;
  int? author;
  int? content;

  Reaction(
      {this.id, this.authorName, this.reactionType, this.author, this.content});

  Reaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorName = json['author_name'];
    reactionType = json['reaction_type'];
    author = json['author'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author_name'] = this.authorName;
    data['reaction_type'] = this.reactionType;
    data['author'] = this.author;
    data['content'] = this.content;
    return data;
  }
}

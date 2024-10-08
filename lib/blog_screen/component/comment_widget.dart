import 'package:fe_garbage_classification_app/blog_screen/models/Comment.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(comment.authorAvatar.toString()),
              ),
              SizedBox(width: 8),
              // Tên người dùng và nội dung
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.authorName.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                    Text('${comment.createdAt.toString()}',style: TextStyle(color: Colors.grey,fontSize: 10.0),),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:Text(
              comment.content??'#notthing there!',
              style: const TextStyle(color: Colors.black,fontSize: 15),
            ),
          ),
          
          // Nút tương tác
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.reply),
                onPressed: () {},
              ),
            ],
          ),
          /*
          if (comment.replies.isNotEmpty)
            Column(
              children: comment.replies.map((reply) => CommentWidget(comment: reply)).toList(),
            ),*/
        ],
      ),
    );
  }
}
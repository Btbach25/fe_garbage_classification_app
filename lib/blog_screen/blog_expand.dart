import 'package:fe_garbage_classification_app/blog_screen/comment_widget.dart';
import 'package:fe_garbage_classification_app/blog_screen/models/Comment.dart';
import 'package:fe_garbage_classification_app/blog_screen/postwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogExpand extends StatefulWidget {
  final aPostWidget this_widget;

  const BlogExpand({
    super.key,
    required this.this_widget,
  });

  @override
  State<BlogExpand> createState() => _BlogExpandState();
}

class _BlogExpandState extends State<BlogExpand> {
  List<Comment> comments = [];
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Profile section
            aPostWidget(
              profileImageUrl: widget.this_widget.profileImageUrl,
              username: widget.this_widget.username,
              timestamp: widget.this_widget.timestamp,
              title: widget.this_widget.title,
              content: widget.this_widget.content,
              canPress: false,
            ),
            // Post details (title, optional actions)

            SizedBox(height: 30),

            ListView.builder(
              shrinkWrap: true, // Wrap content vertically
              physics: NeverScrollableScrollPhysics(), // Prevent unnecessary scrolling
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return CommentWidget(comment: comments[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(String content) {
    if (content.startsWith('http')) {
      // Handle image (use CachedNetworkImage for optimization)
      return Image.network(content, fit: BoxFit.cover);
    } else if (content.endsWith('.mp4')) {
      // Handle video (use video_player package)
      return Text(content); // Replace with your video player implementation
    } else {
      // Default to text
      return Text(content);
    }
  }
}
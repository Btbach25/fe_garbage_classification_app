import 'package:fe_garbage_classification_app/blog_screen/api/comment_api.dart';
import 'package:fe_garbage_classification_app/blog_screen/component/comment_widget.dart';
import 'package:fe_garbage_classification_app/blog_screen/models/Comment.dart';
import 'package:fe_garbage_classification_app/blog_screen/component/postwidget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class BlogExpand extends StatefulWidget {
  final aPostWidget this_widget;
  final int? id_post;
  const BlogExpand({
    super.key,
    required this.this_widget,
    required this.id_post,
  });

  @override
  State<BlogExpand> createState() => _BlogExpandState();
}

class _BlogExpandState extends State<BlogExpand> {
  List<Comment> comments = [];
  bool isLoading = true;
  final TextEditingController _commentEditingController = TextEditingController();

  @override
  void initState() {
    fetchAndAssignComments();
    super.initState();
  }

  Future<void> fetchAndAssignComments() async {
    try {
      List<Comment> newPosts = await CommentApi.getComment(widget.id_post!);
      comments = newPosts;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  void dispose() {
    _commentEditingController.dispose();
    super.dispose();
  }
  Future<void> _handleAddComment() async{
    final String  comment = _commentEditingController.text;

    Comment post = new Comment(content: comment);
    try{
      await CommentApi.uploadComment(widget.id_post!,post);
      fetchAndAssignComments();
      _commentEditingController.clear();
    } catch (e) {
      print('Failed to post blog: $e');
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 5.0,bottom:70 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Profile section
            aPostWidget(
              user_id: widget.this_widget.user_id,
              post: widget.this_widget.post,
              id_post: widget.this_widget.id_post,
              profileImageUrl: widget.this_widget.profileImageUrl,
              username: widget.this_widget.username,
              timestamp: widget.this_widget.timestamp,
              title: widget.this_widget.title,
              content: widget.this_widget.content,
              canPress: false,
              react_id: widget.this_widget.react_id,
              onChildClick: widget.this_widget.onChildClick,
              loadpage: widget.this_widget.loadpage,
            ),
            SizedBox(height: 30),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return CommentWidget(comment: comments[index]);
              },
            ),
          ],
        ),
      ),
      bottomSheet: AnimatedPadding(
        padding: EdgeInsets.only(bottom: 5),
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _commentEditingController,
                  maxLines: 5,
                  minLines: 1,
                  // onFieldSubmitted: (value) => _handleAddComment(),
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Enter a description'),
                  ]),
                  decoration: InputDecoration(
                    hintText: 'Viết bình luận...',
                    constraints: const BoxConstraints(maxWidth: 500.0),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromARGB(255, 79, 187, 90)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                color: Color.fromARGB(255, 79, 187, 90),
                onPressed: _handleAddComment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

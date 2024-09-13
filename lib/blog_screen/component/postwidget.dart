import 'package:fe_garbage_classification_app/blog_screen/api/blog_api.dart';
import 'package:fe_garbage_classification_app/blog_screen/api/reaction_api.dart';
import 'package:fe_garbage_classification_app/blog_screen/blog_expand.dart';
import 'package:fe_garbage_classification_app/blog_screen/models/Post.dart';
import 'package:fe_garbage_classification_app/blog_screen/models/Reaction.dart';
import 'package:flutter/material.dart';

class aPostWidget extends StatefulWidget {
  Post? post;
  final int? id_post;
  final String? profileImageUrl;
  final String? username;
  final String? timestamp;
  final String? title;
  int? react_id;
  final String? content; // Can be text, image path, or video URL
  final bool canPress;
  final VoidCallback onChildClick;
  final VoidCallback loadpage;
  aPostWidget({
    super.key,
    required this.post,
    required this.id_post,
    required this.profileImageUrl,
    required this.username,
    required this.timestamp,
    required this.title,
    required this.content,
    required this.canPress,
    required this.react_id,
    required this.onChildClick,
    required this.loadpage,
  });

  @override
  State<aPostWidget> createState() => _aPostWidgetState();
}

class _aPostWidgetState extends State<aPostWidget> {
  bool isLoading = false; 

  Future<void> _likeContent() async{
    Reaction react = await ReactionApi.uploadReaction(widget.id_post!);
    setState(() {
      widget.react_id = react.id;
      widget.post?.react_id = react.id;
    });
      
  }
  Future<void> _unLike() async{
    await ReactionApi.deleteReaction(widget.react_id!);
    setState(() {
      widget.react_id = 0;
      widget.post?.react_id = 0;
    });
    
  }



  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator()); 
    }
    return  Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 7.0), // Adjust padding as needed
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            overlayColor: Colors.grey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(5),
                bottom: Radius.circular(5),
              ),
            ),
            side: BorderSide.none, // Loại bỏ viền
            backgroundColor: Color.fromARGB(255, 255, 250, 250),
            padding: const EdgeInsets.only(top: 15, bottom: 10, left: 25, right: 15),
          ),
          onPressed: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.profileImageUrl!),
                        radius: 24.0, // Adjust avatar size
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.username!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 16.0)),
                          Text(widget.timestamp!, style: const TextStyle(fontSize: 10.0, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context)=>[
                      PopupMenuItem(
                        value: 0,
                        child: Text('Delete post'),
                        onTap: () async {
                          await Blog_api.deletePost(widget.id_post!);
                          widget.loadpage();
                        },
                      ),
                    ]
                  )
                  
                ],
              ),
              const SizedBox(height: 10.0),
              Text(widget.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black)),
              const SizedBox(height: 10.0),
              _buildContent(widget.content!), // Dynamically handle different content types
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: widget.react_id==0
                        ? Image.asset(
                            'assets/icon/favorite.png',
                            width: 20,
                            height: 20,
                            color: Colors.black,
                          )
                        : Image.asset(
                            'assets/icon/filled_heart.png',
                            width: 20,
                            height: 20,
                          ),
                    onPressed: () {
                      widget.react_id!=0?_unLike():_likeContent();
                    },
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () async {
                      if (widget.canPress) {
                        try {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogExpand(
                                  this_widget: widget,
                                  id_post: widget.id_post,
                              )
                            )
                          );
                          widget.onChildClick();
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    icon: Image.asset(
                      'assets/icon/comment.png',
                      width: 20,
                      height: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
      return Text(
        content,
        style: const TextStyle(color: Colors.black,fontSize: 15.0),
      );
    }
  }
}

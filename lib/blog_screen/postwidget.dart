import 'package:fe_garbage_classification_app/blog_screen/blog_expand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class aPostWidget extends StatefulWidget {
  final String? profileImageUrl;
  final String? username;
  final String? timestamp;
  final String? title;
  final String? content; // Can be text, image path, or video URL
  final bool canPress;

  const aPostWidget({
    super.key,
    required this.profileImageUrl,
    required this.username,
    required this.timestamp,
    required this.title,
    required this.content,
    required this.canPress,
  });

  @override
  State<aPostWidget> createState() => _aPostWidgetState();
}

class _aPostWidgetState extends State<aPostWidget> {
  bool isLiked = true ;
  @override

  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(0), // Adjust padding as needed

        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),

          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), 
                        ),
                      ),
              onPressed:(){
              },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile section
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
                          Text(widget.username!, style: const TextStyle(fontWeight: FontWeight.bold)),
              
                          Text(widget.timestamp!, style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                    Text(widget.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                  // Content section
                 
              
                  const SizedBox(height: 10.0),
                    _buildContent(widget.content!), // Dynamically handle different content types
                  // Post details (title, optional actions)
                  
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      IconButton(
                        icon:isLiked ?Image.asset('assets/icon/favorite.png',
                          width: 20, 
                          height: 20,
                          color: Colors.black,
                        ) : Image.asset('assets/icon/filled_heart.png',
                          width: 20, 
                          height: 20,
              
                        ),      
                                    
                        onPressed: () {
                          setState(() {
                           isLiked = !(isLiked);
                           print('isLiked: $isLiked');
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed:(){
                          if(widget.canPress){
                          try{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BlogExpand(
                              this_widget: widget ,)  ));
                          }catch(e){
                            print(e);
                          }
                          }
                        }, 
                        icon: Image.asset('assets/icon/comment.png',
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
      return Text(content) ; // Replace with your video player implementation
    } else {
      // Default to text
      return Text(content);
    }
  }
}
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
  final List<Widget> actions; // Optional list of action buttons (like, comment, share)

  const aPostWidget({
    super.key,
    required this.profileImageUrl,
    required this.username,
    required this.timestamp,
    required this.title,
    required this.content,
    this.actions = const [
    ],
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
        padding: const EdgeInsets.all(16.0), // Adjust padding as needed
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
                    Text(widget.username!, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),

                    Text(widget.timestamp!, style: const TextStyle(fontSize: 12.0, color: Colors.black)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
              Text(widget.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black)),
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
                  onPressed:(){}, 
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
      return Text(content,style: const TextStyle(color: Colors.black),);
    }
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class aPostWidget extends StatelessWidget {
  final String 
 profileImageUrl;
  final String username;
  final String timestamp;
  final String title;
  final String content; // Can be text, image path, or video URL
  final List<Widget> actions; // Optional list of action buttons (like, comment, share)

  const aPostWidget({
    super.key,
    required this.profileImageUrl,
    required this.username,
    required this.timestamp,
    required this.title,
    required this.content,
    this.actions = const [],
  });

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
                  backgroundImage: NetworkImage(profileImageUrl),
                  radius: 24.0, // Adjust avatar size
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),

                    Text(timestamp, style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Content section
            _buildContent(content), // Dynamically handle different content types

            const SizedBox(height: 10.0),

            // Post details (title, optional actions)
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('See more', style: const TextStyle(fontSize: 12.0, color: Colors.blue)),
                if (actions.isNotEmpty) Row(children: actions) // Display actions if provided
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
      return Text(content);
    }
  }
}
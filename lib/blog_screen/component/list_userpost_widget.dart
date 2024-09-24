import 'package:fe_garbage_classification_app/blog_screen/add_blog.dart';
import 'package:fe_garbage_classification_app/blog_screen/api/blog_api.dart';
import 'package:fe_garbage_classification_app/blog_screen/component/postwidget.dart';
import 'package:fe_garbage_classification_app/blog_screen/models/Post.dart';
import 'package:fe_garbage_classification_app/profile_screen/component/Information_widget.dart';
import 'package:fe_garbage_classification_app/profile_screen/models/Profile.dart';
import 'package:flutter/material.dart';

class myBlogs extends StatefulWidget {
  bool isProfile = false;
  final Profile? myprofile;
   myBlogs({super.key,
    required this.myprofile,
    required this.isProfile,
  });

  @override
  State<myBlogs> createState() => __myBlogsState();
}

class __myBlogsState extends State<myBlogs> {
  
  List<Post> mypost = [];
  bool isLoading = true;
  Future<void> fetchAndAssignPosts() async {
    try {
      List<Post> newPosts = await Blog_api.getPosts(widget.myprofile!.user.toString());
      mypost = newPosts;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
    
  }
  @override
  void initState() {
    fetchAndAssignPosts();
    super.initState();
  }
  
   void updatePost(int index, Post updatedPost) {
    setState(() {
      mypost[index] = updatedPost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Color.fromARGB(255, 145, 166, 143),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0), // Thêm padding nếu cần
          children: [
          !widget.isProfile?const SizedBox(height: 0,):Column(children: [InforWidget(profile: widget.myprofile,),SizedBox(height: 10,)],),
          Container(
            color: const Color.fromARGB(255, 255, 250, 250),
            child: !widget.isProfile? Row(
              children: [
               Container(
                  padding: const EdgeInsets.all(10),
                  color: const Color.fromARGB(255, 255, 250, 250),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.myprofile!.avatar.toString()),
                    radius: 24.0, // Adjust avatar size
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        overlayColor: const Color.fromARGB(255, 158, 158, 158),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                            bottom: Radius.circular(15),
                          ),
                        ),
                        side: BorderSide(
                          color: Colors.grey, 
                          width: 2.0,
                        ),
                      ),
                      onPressed: () {
                        try {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddBlog()),
                          );
                        } catch (e) {
                          print("Error: $e");
                        }
                      },
                      label: const Text("What's on your mind?"),
                    ),
                  ),
                ),
              ],
            ):const SizedBox(height: 0,),
          ),

          ... mypost.asMap().entries.map((entry) {
            int index = entry.key;
            var e = entry.value;   
            return
              aPostWidget(
                user_id: e.author,
                post: e,
                id_post: e.id,
                profileImageUrl: e.authorAvatar,
                username: e.authorName,
                timestamp: e.createdAt,
                title: e.title,
                content: e.content,
                canPress: true,
                react_id: e.react_id,
                onChildClick: () {
                  updatePost(index,e); 
                },
                loadpage: (){
                  fetchAndAssignPosts();
                },
              );
            }).toList(),
          ],
        ),
    );
  }
}

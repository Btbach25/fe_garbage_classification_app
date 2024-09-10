import 'dart:ui';

import 'package:fe_garbage_classification_app/blog_screen/add_blog.dart';
import 'package:fe_garbage_classification_app/blog_screen/api/blog_api.dart';
import 'package:fe_garbage_classification_app/blog_screen/models/Post.dart';
import 'package:fe_garbage_classification_app/blog_screen/component/postwidget.dart';
import 'package:fe_garbage_classification_app/start_screen/api/google_sign_in.dart';
import 'package:fe_garbage_classification_app/start_screen/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';  
class homeblog_ extends StatefulWidget {
  const homeblog_({super.key});

  @override
  State<homeblog_> createState() => _homeblog_State();
}

class _homeblog_State extends State<homeblog_> {
  var selectedIndex = 0;  
  DateTime? lastPressed;

  //Method handle pop up
  Future<bool> _onWillPop() async { 
    final DateTime now = DateTime.now();
    if (lastPressed == null || now.difference(lastPressed!) > Duration(seconds: 2)) { //Set the interval to 2 clicks
      lastPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nhấn thêm lần nữa để thoát')),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
  Future<void> _signout() async {

    final prefs = await SharedPreferences.getInstance();
    //Delete token
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');

    GoogleSignInApi.logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => welcum_()  )); 
  }
  @override
  Widget build(BuildContext context) {
    
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = _newsfeed();
        
    case 1:
        page = _myBlogs();
    default:
    throw UnimplementedError('no widget for $selectedIndex');
    }
    return PopScope( 
      //Pressing back twice will exit the application
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await _onWillPop() ?? false;
        if (context.mounted && shouldPop) {
          GoogleSignInApi.logout();
          await SystemNavigator.pop();
        }
      },
      child:
     LayoutBuilder(
      builder: (context,constraints) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 250, 250),
          appBar: AppBar(
            backgroundColor:Color.fromARGB(255, 255, 250, 250),
            title: Text("What's news"),
            centerTitle: true,
            actions: [
              PopupMenuButton(
                icon: Icon(Icons.menu_outlined),
                itemBuilder: (context)=>[
                  PopupMenuItem(
                    value: 0,
                    child: Text('Text 1'),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text('Text 2'),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text('Text 3'),
                  ),
                ]
              ),
            ]
          ) ,
        
          body: Column(
            children: [
              SafeArea(
                child:
                NavigationBarTheme(
                   data: NavigationBarThemeData(
                    indicatorColor: Colors.black,
                    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return const TextStyle(
                              color: Color(0xFF277114), 
                              fontWeight: FontWeight.bold,
                            );
                          }
                          return const TextStyle(
                            color: Colors.black, 
                          );
                        },
                      ),
                    ),
                  child: NavigationBar(
                    
                    backgroundColor: Color.fromARGB(255, 255, 250, 250),
                    height: 70,
                    destinations: const [
                        //Text('Home'),
                       NavigationDestination(
                        icon: Icon(Icons.home, ), 
                          label:  'Home',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.person), 
                          label: 'Your Post',
                        ),
                    ],
                    selectedIndex: selectedIndex,
                        onDestinationSelected: (value) {
                          setState(() {
                              selectedIndex = value;
                            }
                          );
                        },
                        indicatorColor: const Color.fromARGB(121, 115, 180, 99),
                    ),
                ),
              ),
              Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: page,
                    ),
                  ),
            ],
            ),
          floatingActionButton: FloatingActionButton(
            onPressed:(){_signout();},
            child: Icon(Icons.home,),
          ),

        );
      }
    )
    );
  }
}

class _newsfeed extends StatefulWidget {
  @override
  State<_newsfeed> createState() => __newsfeedState();
  const _newsfeed({super.key});
}

class __newsfeedState extends State<_newsfeed> with WidgetsBindingObserver {
  List<Post> mypost = [];
  bool isLoading = true;
  Future<void> fetchAndAssignPosts() async {
    try {
      List<Post> newPosts = await Blog_api.getPosts("");
      mypost = newPosts;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
    
  }
  void updatePost(int index, Post updatedPost) {
    setState(() {
      mypost[index] = updatedPost;
    });
  }
  @override
  void initState() {
    fetchAndAssignPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color.fromARGB(255, 145, 166, 143),
      child: isLoading?const Center(
        child: SizedBox(        
          width: 30, 
          height: 30, 
          child: CircularProgressIndicator(
            strokeWidth: 4.0, 
          ),
      )):
      ListView(
  children: mypost.asMap().entries.map((entry) {
          int index = entry.key;
          var e = entry.value;   
          return aPostWidget(
            post: e,
            id_post: e.id,
            profileImageUrl: 'https://www.reddit.com/r/discordapp/comments/6n389p/any_way_to_find_the_image_url_of_someones_avatar/',
            username: e.authorName,
            timestamp: e.createdAt,
            title: e.title,
            content: e.content,
            canPress: true,
            react_id: e.react_id,
            onChildClick: () {
              updatePost(index,e); 
            },
          );
        }).toList(),
      ),
    );
  }
}


class _myBlogs extends StatefulWidget {
  const _myBlogs({super.key});

  @override
  State<_myBlogs> createState() => __myBlogsState();
}

class __myBlogsState extends State<_myBlogs> {
  
  List<Post> mypost = [];
  bool isLoading = true;
  Future<void> fetchAndAssignPosts() async {
    try {
      List<Post> newPosts = await Blog_api.getPosts("me/");
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
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 145, 166, 143),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0), // Thêm padding nếu cần
          children: [
          Container(
            color: Color.fromARGB(255, 255, 250, 250),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Color.fromARGB(255, 255, 250, 250),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://www.reddit.com/r/discordapp/comments/6n389p/any_way_to_find_the_image_url_of_someones_avatar/'),
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
            ),
          ),

          ... mypost.asMap().entries.map((entry) {
            int index = entry.key;
            var e = entry.value;   
            return
              aPostWidget(
                post: e,
                id_post: e.id,
                profileImageUrl: 'https://www.reddit.com/r/discordapp/comments/6n389p/any_way_to_find_the_image_url_of_someones_avatar/',
                username: e.authorName,
                timestamp: e.createdAt,
                title: e.title,
                content: e.content,
                canPress: true,
                react_id: e.react_id,
                onChildClick: () {
                  updatePost(index,e); 
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

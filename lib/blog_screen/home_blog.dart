import 'dart:ui';

import 'package:fe_garbage_classification_app/blog_screen/add_blog.dart';
import 'package:fe_garbage_classification_app/blog_screen/api/blog_api.dart';
import 'package:fe_garbage_classification_app/blog_screen/models/Post.dart';
import 'package:fe_garbage_classification_app/blog_screen/postwidget.dart';
import 'package:fe_garbage_classification_app/start_screen/network/google_sign_in.dart';
import 'package:fe_garbage_classification_app/start_screen/welcome.dart';
import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
          backgroundColor: Color(0xFFF4EDED),
          appBar: AppBar(
            backgroundColor:Color(0xFFF4EDED) ,
            title: Text("What's news"),
            centerTitle: true,
            actions: [
              IconButton(
              icon: Icon(Icons.person),
                
              onPressed:_signout,
            ),
            ]
          ) ,
        
          body: Column(
            children: [
              SafeArea(
                child: NavigationBar(
                  backgroundColor: Color(0xFFF4EDED),
                  height: 70,
                  destinations: [
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

class __newsfeedState extends State<_newsfeed> {
  List<Post> mypost = [];
  bool isLoading = true;
  Future<void> fetchAndAssignPosts() async {
    try {
      List<Post> newPosts = await Blog_api.getPosts();
      mypost = newPosts;
      print(mypost);
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
     color: Colors.white,
      child: isLoading?const Center(
        child: SizedBox(        
          width: 30, // Chiều rộng mong muốn
          height: 30, // Chiều cao mong muốn
          child: CircularProgressIndicator(
            strokeWidth: 4.0, // Độ dày của vòng tròn tải
          ),
      )):
      ListView(
        children: mypost.map((e){

          return aPostWidget(profileImageUrl: 'https://www.reddit.com/r/discordapp/comments/6n389p/any_way_to_find_the_image_url_of_someones_avatar/ ', 
              username: e.authorName , timestamp: e.createdAt, title: e.title, content: e.content, canPress: true, );
        }).toList(),
        // [
        // Padding(
          // padding: const EdgeInsets.all(8.0),
          // child: OutlinedButton(
          //   style: OutlinedButton.styleFrom(
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(15), 
          //               ),
          //             ),
          //   onPressed:(){
          //   },
        //      child: aPostWidget(profileImageUrl: 'https://www.reddit.com/r/discordapp/comments/6n389p/any_way_to_find_the_image_url_of_someones_avatar/ ', username: 'Bachbui', timestamp: '12/3/2024', title: 'Tiếng Việt', content: 'Text' ),
        //   ),
        // ),
        // aPostWidget(profileImageUrl: 'https://www.reddit.com/r/discordapp/comments/6n389p/any_way_to_find_the_image_url_of_someones_avatar/ ', username: 'Bachbui', timestamp: '12/3/2024', title: 'Nothing there!', content: 'Text'),
        
        // ],
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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              SizedBox(
                width: double.infinity,
                height: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20,),
                    child: OutlinedButton.icon(
                      onPressed:(){
                        try{
                         Navigator.push(context, MaterialPageRoute(builder: (context) => AddBlog()  ));
                         }catch(e){
                         print(e);
                        }
                      },
                      icon: Icon( Icons.add),
                      label: const Text('Add new blog !'),
                    ),
                  ),
              ),
          ],
        ),
      ),
    );
  }
}

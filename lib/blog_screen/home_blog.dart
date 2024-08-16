import 'package:fe_garbage_classification_app/blog_screen/add_blog.dart';
import 'package:fe_garbage_classification_app/blog_screen/post_widget.dart';
import 'package:fe_garbage_classification_app/blog_screen/postwidget.dart';
import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';  
class homeblog_ extends StatefulWidget {
  const homeblog_({super.key});

  @override
  State<homeblog_> createState() => _homeblog_State();
}

class _homeblog_State extends State<homeblog_> {

   var selectedIndex = 0;  

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
    return LayoutBuilder(
      builder: (context,constraints) {
        return Scaffold(
          appBar: AppBar(
        
            title: Text("What's news"),
            centerTitle: true,
            actions: [
              IconButton(
              icon: Icon(Icons.person),
              onPressed:(){},
            ),
            ]
          ) ,
        
          body: Column(
            children: [
              SafeArea(
                child: NavigationBar(
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
        
        );
      }
    );
  }
}




class _newsfeed extends StatefulWidget {
  const _newsfeed({super.key});

  @override
  State<_newsfeed> createState() => __newsfeedState();
}

class __newsfeedState extends State<_newsfeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
        aPostWidget(profileImageUrl: 'https://www.reddit.com/r/discordapp/comments/6n389p/any_way_to_find_the_image_url_of_someones_avatar/ ', username: 'Bachbui', timestamp: '12/3/2024', title: 'Nothing there!', content: 'Text'),
        
        ],
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
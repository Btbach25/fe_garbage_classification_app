import 'package:camera/camera.dart';
import 'package:fe_garbage_classification_app/blog_screen/home_blog.dart';
import 'package:fe_garbage_classification_app/cameraPage/cameraPage.dart';
import 'package:fe_garbage_classification_app/home_screen/home_screen.dart';
import 'package:fe_garbage_classification_app/profile_screen/api/getProfile.dart';
import 'package:fe_garbage_classification_app/profile_screen/models/Profile.dart';
import 'package:fe_garbage_classification_app/start_screen/api/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class homePage extends StatefulWidget {
  Profile? profile;
  final int index;
  homePage({super.key,
    required this.index,
    required this.profile,
  });

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  int selectedIndex=0;
  List<CameraDescription> _cameras = [];
  late CameraController _controller;
  bool isLoading = true;
  void loadProfile() async {
    setState(() async {
      widget.profile = await ProfileAPI.getMyProfile();  
      isLoading = false;
    });
    
  }

  @override
  void initState() {
    selectedIndex = widget.index;
    loadProfile();
    super.initState();
    availableCameras().then((availableCameras) {
      _cameras = availableCameras;
      if (_cameras.length > 0) {
        _controller = CameraController(_cameras[0], ResolutionPreset.medium);
        _controller.initialize().then((_) {
          if (!_controller.value.hasError) {
            setState(() {});
          } else {
            // Handle camera initialization error
            print('Camera initialization error: ${_controller.value.errorDescription}');
          }
        });
      } else {
        // No cameras found
        print('No cameras found');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  void _onItemTapped(int index) {
    setState(() { // Update state when a tab is tapped
      selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomeScreen(profile: widget.profile,); 
        break;
      case 1:
        page =  homeblog_(myprofile: widget.profile,);
        break;
      case 2:
        page = CameraPage( cameras : _cameras , controller: _controller, );
        break;
      case 3:
        page =  HomeScreen(profile: widget.profile,);
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
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
    return PopScope(
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
      child: Scaffold(
        body: isLoading?const Center(
        child: SizedBox(        
          width: 30, 
          height: 30, 
          child: CircularProgressIndicator(
            strokeWidth: 4.0, 
          ),
      )):page,
        
        bottomNavigationBar: Container(
          color: Colors.lightGreen,
          child: BottomNavigationBar(
            backgroundColor: Colors.amberAccent,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home) ,
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Blogs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                label: 'Camera',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.quiz),
                label: 'Quizz',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
import 'package:camera/camera.dart';
import 'package:fe_garbage_classification_app/blog_screen/home_blog.dart';
import 'package:fe_garbage_classification_app/cameraPage/cameraPage.dart';
import 'package:fe_garbage_classification_app/home_screen/home_screen.dart';
import 'package:flutter/material.dart';



class homePage extends StatefulWidget {
  final int index;
  const homePage({super.key,
  required this.index,});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  int selectedIndex=0;
  List<CameraDescription> _cameras = [];
  late CameraController _controller;

  @override
  void initState() {
    selectedIndex = widget.index;
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
        page = HomeScreen(); // Replace with HomePage() if it's a class
        break;
      case 1:
        page =  homeblog_();
        break;
      case 2:
        page = CameraPage( cameras : _cameras , controller: _controller, );
        break;
      case 3:
        page =  HomeScreen();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      
      body: page,
      
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
              icon: Icon(Icons.camera),
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
    );
  }
}
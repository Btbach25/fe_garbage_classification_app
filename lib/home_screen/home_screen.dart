import 'package:fe_garbage_classification_app/home_screen/auto_swapbanner.dart';
import 'package:fe_garbage_classification_app/profile_screen/models/Profile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Profile profile;
  const HomeScreen({super.key, required this.profile});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
          
          title: Column(
            children: [
              Text('Welcome ,', style: TextStyle(fontSize: 13, ),),
              Text(widget.profile.name.toString(), style: TextStyle( fontWeight: FontWeight.bold,fontSize: 15,),),
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green,
                          width: 2,
                        )
                      ),
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pinimg.com/564x/bb/48/3f/bb483f7b9c140655630632c7664a5477.jpg') ,
                radius: 30,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Xử lý khi nút tìm kiếm được nhấn 
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Xử lý khi nút tìm kiếm được nhấn
              },
            ),
          ],
        ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.75,
                height: MediaQuery.of(context).size.width*0.55,
                child: AutoSwapBanner(
                  imageUrls: [
                  'https://i.pinimg.com/564x/bb/48/3f/bb483f7b9c140655630632c7664a5477.jpg',
                  'https://i.pinimg.com/736x/3a/90/b0/3a90b00bd095d61f50b478aaae1da14b.jpg',
                  'https://i.pinimg.com/736x/55/33/65/55336531569bf9ec16b44bc771b3dd89.jpg',
                  'https://i.pinimg.com/564x/2f/0e/6e/2f0e6eedcd3e15019bcf0f3d8bc550a7.jpg',
                  ],
                ),
              ),
            ],
          ),
          Text("Nothing!"),
        ],
      )
    );
  }
}
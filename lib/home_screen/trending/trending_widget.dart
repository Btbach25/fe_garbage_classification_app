import 'package:fe_garbage_classification_app/home_screen/trending/mini_post_widget.dart';
import 'package:flutter/material.dart';

class trendingWid extends StatefulWidget {
  const trendingWid({super.key});

  @override
  State<trendingWid> createState() => _trendingWidState();
}

class _trendingWidState extends State<trendingWid> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width - 20, 
            //height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      Text("Trending !" ,  style: TextStyle( fontSize: 20 ,  color:Color.fromARGB(255, 79, 187, 90), fontWeight: FontWeight.bold , ),),
                    ],
                  )
                ),
                
                miniPostWidget(),
                miniPostWidget(),
                miniPostWidget(),
                miniPostWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
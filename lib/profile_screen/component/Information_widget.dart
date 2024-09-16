import 'package:fe_garbage_classification_app/profile_screen/models/Profile.dart';
import 'package:flutter/material.dart';

class InforWidget extends StatelessWidget {
  final Profile profile;

  const InforWidget({
    Key? key,
    required this.profile,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 0,),
                Text(
                  "Profile", style: TextStyle(fontWeight:FontWeight.bold , fontSize: 20 ),
                ),
                SizedBox(width: 0,),
                SizedBox(width: 0,),
                SizedBox(width: 0,),
                SizedBox(width: 0,),
                SizedBox(width: 0,),
                IconButton(
                  onPressed:(){}, 
                  icon: Icon(Icons.settings),
                  ),
                SizedBox(width: 0,),
              ],
            ),
            SizedBox(height: 50,),
            CircleAvatar(
              radius: 50,
              backgroundImage: profile.avatar,
            ),
            SizedBox(height: 16),
            Text(
              "Null" ,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Mô tả
            Text(
              'This is my profile description.',
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 40),
            // Row chứa số bài viết, follower, like
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //SizedBox(width: 10,),
                Column(
                  children: [
                    Text('Posts', style: TextStyle(fontWeight: FontWeight.bold)), 
                    Text('100'),
                  ],
                ),
                /*
                Column(
                  children: [
                    Text('Followers', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('500'),
                  ],
                ),*/
                Column(
                  children: [
                    Text('Likes', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('2000'),
                  ],
                ),
                //SizedBox(width: 10,),
              ],
            ),
          ],
        ),
      ),
    );
    /*
    return Padding(
           padding: const EdgeInsets.only(top:10),
           child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green,
                          width: 4,
                        )
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("https://i.pinimg.com/236x/c5/77/99/c5779904a839e55c9592426d0c9ce5ca.jpg"),
                        radius: 50.0, 
                        
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        profile.name.toString(),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
         );*/
  }
}
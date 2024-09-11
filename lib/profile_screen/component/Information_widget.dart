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
         );
  }
}
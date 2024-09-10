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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://kynguyenlamdep.com/wp-content/uploads/2022/06/avatar-cute-meo-con-than-chet.jpg"),
                    radius: 50.0, 
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
         );
  }
}
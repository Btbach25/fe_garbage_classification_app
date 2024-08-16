
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), 
                      ),
                    ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  SizedBox(width: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width / 4.5 ,
                    height: MediaQuery.of(context).size.width / 4.5 ,
                    child: Image.asset('assets/images/login_logo.png'),
                  ),
                ]
              ),
              Container(
                width: double.infinity,
                child: Image.asset('assets/examp_img/blog_ex.png'),
              ),
              SizedBox(height: 8,),
              Text('Title' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 13, ),),
              SizedBox(height: 8,),
              Text('dd/mm/yyyy', style: TextStyle(fontSize: 10),),
            ],
          ),
          onPressed: (){

          },
        ),
      ),
    );
    
  }
}
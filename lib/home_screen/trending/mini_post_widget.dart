import 'package:flutter/material.dart';

class miniPostWidget extends StatefulWidget {
  const miniPostWidget({super.key});

  @override
  State<miniPostWidget> createState() => _miniPostWidgetState();
}

class _miniPostWidgetState extends State<miniPostWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(padding: EdgeInsets.all(8),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
              color: Theme.of(context).colorScheme.background,
              width: 0,
            ),
          ),
          
          onPressed:(){}, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 190,
                height: 120,
                child:ClipRRect( 
                  borderRadius: BorderRadius.circular(20.0),
                  child : Image(
                    image: NetworkImage('https://i.pinimg.com/564x/bb/48/3f/bb483f7b9c140655630632c7664a5477.jpg'), fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('First text!', style: TextStyle( fontSize: 15 , fontWeight: FontWeight.bold ),),
                    Text('Second text!'),
                    Text('dd/mm/yyyy'),
                  ],
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
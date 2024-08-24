import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Getusername extends StatefulWidget {
  const Getusername({super.key});

  @override
  State<Getusername> createState() => _GetusernameState();
}

class _GetusernameState extends State<Getusername> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
         appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: Color.fromARGB(0, 61, 233, 4) ,
          //title: Text('Welcome back !'),
          //centerTitle: true,
           //,
         ),
         body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only( top : 0.0),
                child: Center(
                  child: Container(
                    width: 400,
                    height: 400,
                    child: Image.asset('assets/images/login_img.png'),
                    ),
                  ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only( left: 25),
                    child: Column(
                      children: <Widget>[
                        Text('Everything is done!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold , color: Color.fromARGB(255, 79, 187, 90)),),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only( left: 29),
                    child: Column(
                      children: <Widget>[
                        Text('What should I call you?'),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                          padding: const EdgeInsets.all(31.0),
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Enter your username !'),
                              //EmailValidator(errorText: 'Correct email filled !'),
                            ]),
                            decoration: InputDecoration(
                              hintText: 'Enter Username' , 
                              labelText:  'Username' ,
                              prefixIcon: Icon(Icons.person , color: Color.fromARGB(255, 132, 162, 135), ), 
                              errorStyle: TextStyle(fontSize: 12.0), 
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 79, 187, 90)),
                                borderRadius: BorderRadius.all(Radius.circular(15.0)), 
                              ),
                            ),
                            
                          ),
                ),
              Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                           // color:  Color(0x4FBB5A),
                            child: Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 79, 187, 90)),
                                ),
                                child: Text( 'Enter!', style: TextStyle(color: Colors.white,  fontSize:22 ,  ),) ,                                                              
                                onPressed:(){},
                              ),
                            ),
                            width: MediaQuery.of(context).size.width, 
                            height: 50, 
                          ),
                        ),
            ],
            ) ,
        ),
    );
  }
}
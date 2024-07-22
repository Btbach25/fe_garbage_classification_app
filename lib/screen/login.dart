
import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart'; 
import 'package:form_field_validator/form_field_validator.dart';

class Login_ extends StatefulWidget {
  const Login_({super.key});

  @override
  State<Login_> createState() => _Login_State();
}

class _Login_State extends State<Login_> {
  final _formkey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // 
              // Logo - Image on top login screen 
              Padding(
                padding: const EdgeInsets.only( top : 30.0),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                     // borderRadius: BorderRadius.circular(40),
                      //border: Border.all(color: Colors.grey),
                    ),
                    child: Image.asset('assets/images/login_img.png'),
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Padding(
                  padding: const EdgeInsets.all( 12.0) ,
                  child: Form(
                    key: _formkey, 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Enter email address !'),
                              EmailValidator(errorText: 'Correct email filled !'),
                            ]),
                            decoration: InputDecoration(
                              hintText: 'Enter email' , 
                              labelText:  'Your email' ,
                              prefixIcon: Icon(Icons.email), 
                              errorStyle: TextStyle(fontSize: 18.0), 
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(Radius.circular(9.0)), 
                              ),
                            ),
                          ),
                        ),
                        Padding( 
                            padding: const EdgeInsets.all(12.0), 
                            child: TextFormField( 
                              validator: MultiValidator([ 
                                RequiredValidator( 
                                    errorText: 'Please enter Password'), 
                                MinLengthValidator(8, 
                                    errorText: 
                                        'Password must be atlist 8 digit'), 
                                PatternValidator(r'(?=.*?[#!@$%^&*-])', 
                                    errorText: 
                                        'Password must be atlist one special character') 
                              ]), 
                              decoration: InputDecoration( 
                                hintText: 'Enter Password', 
                                labelText: 'Your password', 
                                prefixIcon: Icon( 
                                  Icons.key, 
                                  color: Colors.green, 
                                ), 
                                errorStyle: TextStyle(fontSize: 18.0), 
                                border: OutlineInputBorder( 
                                    borderSide: BorderSide(color: Colors.red), 
                                    borderRadius: 
                                        BorderRadius.all(Radius.circular(9.0))), 
                              ), 
                            ), 
                          ), 
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
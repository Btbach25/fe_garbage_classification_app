
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
  bool _isPasswordHidden = true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
         appBar: AppBar(
          backgroundColor: Color.fromARGB(0, 61, 233, 4) ,
          title: Text('Welcome back !'),
          centerTitle: true,
           //,
         ),
        body: SingleChildScrollView(
          
          child: Column(
            
            children: <Widget>[
              // 
              // Logo - Image on top login screen 
              Padding(
                padding: const EdgeInsets.only( top : 0.0),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Color(0x4FBB5A)),
                    ),
                    child: Image.asset('assets/images/login_img.png'),
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Padding(
                  padding: const EdgeInsets.all( 8.0) ,
                  child: Form(
                    key: _formkey, 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //
                        // Email box 
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Enter email address !'),
                              EmailValidator(errorText: 'Correct email filled !'),
                            ]),
                            decoration: InputDecoration(
                              hintText: 'Enter email' , 
                              labelText:  'Your email' ,
                              prefixIcon: Icon(Icons.email), 
                              errorStyle: TextStyle(fontSize: 12.0), 
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0x4FBB5A)),
                                borderRadius: BorderRadius.all(Radius.circular(15.0)), 
                              ),
                            ),
                            
                          ),
                        ),
                        //
                        // Password Box 
                        Padding( 
                            padding: const EdgeInsets.all(8.0), 
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
                              obscureText: _isPasswordHidden,
                              decoration: InputDecoration( 
                                hintText: 'Enter Password', 
                                labelText: 'Your password', 
                                prefixIcon: Icon( 
                                  Icons.key, 
                                  //color: Colors.green, 
                                ), 
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordHidden ? Icons.visibility_off: Icons.visibility ),
                                  onPressed:(){
                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden; 
                                    });
                                  },
                                ),
                                errorStyle: TextStyle(fontSize: 12.0), 
                                border: OutlineInputBorder( 
                                    
                                    borderSide: BorderSide(color: Color(0x4FBB5A) ), 
                                    borderRadius: 
                                        BorderRadius.all(Radius.circular(15.0))), 
                              ), 
                            ), 
                        ),
                        //
                        // Forgot password and sign up
                        Row(
                          children: <Widget>[
                            Padding( 
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0), 
                                child: TextButton(
                                  child: Text( 'Forgot Password', style: TextStyle(color: Colors.black  ),  ),
                                  onPressed:(){
                                    print('Nothing there! ');
                                  },
                                ),
                            ),
                            Padding( 
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0), 
                                  child: Text( 'or', style: TextStyle(color: Colors.black  ),  ),                                                                                                                         
                            ),
                            Padding( 
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0), 
                                child: TextButton(
                                  child: Text( 'new user ?', style: TextStyle(color: Colors.black  ),  ),
                                  onPressed:(){
                                    print('Nothing there! ');
                                  },
                                ), 
                                
                                                        
                            ),
                          ],
                        ),
                        //
                        //  Login button 
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                           // color:  Color(0x4FBB5A),
                            child: Center(
                              child: ElevatedButton(
                                child: Text( 'Login', style: TextStyle(color: Colors.black,  fontSize:22 ,  ),) ,                                                              
                                onPressed: (){
                                  if( _formkey.currentState!.validate()){
                                    print('Form submited!'); 
                                  }
                                },
                              ),
                            ),
                            width: MediaQuery.of(context).size.width, 
                              height: 50, 
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0) ,
                            child: Center(
                              child: Text('Or sign in using !'),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Row(children: [                    
                                IconButton(
                                  onPressed:(){}, 
                                  icon: Image.asset('assets/images/fb_icon.png',
                                  height: 40,
                                  width: 40,
                                  ),
                                ),
                                SizedBox(width: 50.0),
                                IconButton(
                                  onPressed:(){}, 
                                  icon: Image.asset('assets/images/gg_icon.png',
                                  height: 40,
                                  width: 40,
                                  )
                                ),
                              ],),
                            ),
                          ],
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
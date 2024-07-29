
import 'package:fe_garbage_classification_app/start_screen/signup.dart';
import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart'; 
import 'package:form_field_validator/form_field_validator.dart';

class Change_pass_ extends StatefulWidget {
  const Change_pass_({super.key});

  @override
  State<Change_pass_> createState() => _Change_pass_State();
}

class _Change_pass_State extends State<Change_pass_> {
  final _formkey = GlobalKey<FormState>(); 
  bool _isPasswordHidden = true ;
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
              // 
              // Logo - Image on top login screen 
              Padding(
                padding: const EdgeInsets.only( top : 0.0),
                child: Center(
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Color(0x4FBB5A)),
                    ),
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
                        Text(' Do not remember your pass ?  ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 79, 187, 90) ),),
                        //Text(' Create your profile and start your journey.'),
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
                        //Text(' Get On Board! ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold ),),
                        Text(' Dont worry, we can help you create a new one :3 '),
                      ],
                    ),
                  ),
                ],
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
                              prefixIcon: Icon(Icons.email,color: Color.fromARGB(255, 79, 187, 90),), 
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.send,color: Color.fromARGB(255, 79, 187, 90),),
                                  onPressed:(){
                                    // send sec code to gmail
                                  },
                                ),
                              errorStyle: TextStyle(fontSize: 12.0), 
                              
                            ),
                            
                          ),
                        ),
                        //
                        // Code box ( about 6 digit) 
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Enter code'),
                              //EmailValidator(errorText: 'Correct email filled !'),
                            ]),
                            decoration: InputDecoration(
                              hintText: 'Enter code (6 digits)' , 
                              labelText:  'Security Code' ,
                              prefixIcon: Icon(Icons.security, color: Color.fromARGB(255, 79, 187, 90),), 
                              errorStyle: TextStyle(fontSize: 12.0), 
                              
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
                                hintText: 'Enter new password', 
                                labelText: 'Your new password', 
                                prefixIcon: Icon( 
                                  Icons.key, 
                                  color: Color.fromARGB(255, 79, 187, 90), 
                                ), 
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordHidden ? Icons.visibility_off: Icons.visibility,color: Color.fromARGB(255, 79, 187, 90), ),
                                  onPressed:(){
                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden; 
                                    });
                                  },
                                ),
                                errorStyle: TextStyle(fontSize: 12.0), 
                                
                              ), 
                            ), 
                        ),
                        //
                        // Forgot password and sign up
                        
                        //
                        //  Login button 
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                           // color:  Color(0x4FBB5A),
                            child: Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 79, 187, 90)),
                                ),
                                child: Text( 'Change to new password', style: TextStyle(color: Colors.white,  fontSize:22 ,  ),) ,                                                              
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [                    
                                
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed:(){},
                                    icon: Image.asset('assets/images/fb_icon.png', width: 20, height: 20 , ),
                                    label: const Text('Sign in with Facebook. '),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed:(){},
                                    
                                    icon: Image.asset('assets/images/gg_icon.png', width: 20, height: 20 , ),
                                    label: const Text('Sign in with Google. '),
                                  ),
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

import 'package:fe_garbage_classification_app/screen/signup.dart';
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only( left: 25),
                    child: Column(
                      children: <Widget>[
                        Text(' Do not remember your pass ?  ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold ),),
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
                              prefixIcon: Icon(Icons.email), 
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed:(){
                                    // send sec code to gmail
                                  },
                                ),
                              errorStyle: TextStyle(fontSize: 12.0), 
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0x4FBB5A)),
                                borderRadius: BorderRadius.all(Radius.circular(15.0)), 
                              ),
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
                              prefixIcon: Icon(Icons.security), 
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
                                hintText: 'Enter new password', 
                                labelText: 'Your new password', 
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
                        
                        //
                        //  Login button 
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                           // color:  Color(0x4FBB5A),
                            child: Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.black),
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
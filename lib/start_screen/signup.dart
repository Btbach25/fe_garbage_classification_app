
import 'package:fe_garbage_classification_app/blog_screen/home_blog.dart';
import 'package:fe_garbage_classification_app/home_page.dart';
import 'package:fe_garbage_classification_app/start_screen/api/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signup_ extends StatefulWidget {
  const Signup_({super.key});

  @override
  State<Signup_> createState() => _Signup_State();
}

class _Signup_State extends State<Signup_> {
  final _formkey = GlobalKey<FormState>(); 
  bool _isPasswordHidden = true ;

  Future<void> _handleGoogleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignInApi.login();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      await GoogleSignInApi.loginWithGoogle(accessToken!);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage(profile: null,index: 0,)  ));
    } catch (error) {
      print(error);
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
         appBar: AppBar(
          //
          toolbarHeight: 30,
          backgroundColor: Color.fromARGB(0, 61, 233, 4) ,
         ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // 
              // Header 
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all( 0.0),
                    child: Container(
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
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only( left: 25),
                    child: Column(
                      children: <Widget>[
                        Text(' Get On Board! ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 79, 187, 90) ),),
                        //Text(' Create your profile and start your journey.'),
                      ],
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only( left: 29),
                    child: Column(
                      children: <Widget>[
                        //Text(' Get On Board! ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold ),),
                        Text(' Create your profile and start your journey.'),
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
                            decoration: const InputDecoration(
                              hintText: 'Enter email' , 
                              labelText:  'Your email' ,
                              prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 79, 187, 90),), 
                              //filled: true ,
                              //fillColor: Color.fromARGB(0, 108, 79, 187),
                              errorStyle: TextStyle(fontSize: 12.0), 
                             border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 79, 187, 90)),
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
                                MinLengthValidator(6, 
                                    errorText: 
                                        'Password must be atlist 6 digit'), 
                                PatternValidator(r'(?=.*?[#!@$%^&*-])', 
                                    errorText: 
                                        'Password must be at least one special character') 
                              ]), 
                              obscureText: _isPasswordHidden,
                              decoration: InputDecoration( 
                                hintText: 'Enter Password', 
                                labelText: 'Your password', 
                                prefixIcon: Icon( 
                                  Icons.key, 
                                  color: Color.fromARGB(255, 79, 187, 90), 
                                ), 
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordHidden ? Icons.visibility_off: Icons.visibility, color: Color.fromARGB(255, 79, 187, 90), ),
                                  onPressed:(){
                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden; 
                                    });
                                  },
                                ),
                                errorStyle: TextStyle(fontSize: 12.0), 
                                border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 79, 187, 90)),
                                borderRadius: BorderRadius.all(Radius.circular(15.0)), 
                              ),
                              ), 
                            ), 
                        ),
                        //
                        // Name box
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Enter your name !'),
                              //EmailValidator(errorText: 'Correct email filled !'),
                            ]),
                            decoration: InputDecoration(
                              hintText: 'Enter Name' , 
                              labelText:  'Your name' ,
                              prefixIcon: Icon(Icons.person , color: Color.fromARGB(255, 79, 187, 90), ), 
                              errorStyle: TextStyle(fontSize: 12.0), 
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 79, 187, 90)),
                                borderRadius: BorderRadius.all(Radius.circular(15.0)), 
                              ),
                            ),
                            
                          ),
                        ),
                        //
                        // already have account
                        /*
                        Row(
                          children: <Widget>[
                            Padding( 
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0), 
                                child: TextButton(
                                  child: Text( 'Already have an account ?', style: TextStyle(color: Colors.black  ),  ),
                                  onPressed:(){
                                    try{
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login_()  ));
                                    }catch(e){
                                      print(e);
                                    }
                                  },
                                ),
                            ),
                            
                          ],
                        ),
                        */
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
                                child: Text( 'Sign Up!', style: TextStyle(color: Colors.white,  fontSize:22 ,  ),) ,                                                              
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
                                    onPressed:_handleGoogleSignIn,
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
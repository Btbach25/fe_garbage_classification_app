
import 'dart:ui';
import 'package:fe_garbage_classification_app/blog_screen/home_blog.dart';
import 'package:fe_garbage_classification_app/start_screen/change_pass.dart';
import 'package:fe_garbage_classification_app/start_screen/network/google_sign_in.dart';
import 'package:fe_garbage_classification_app/start_screen/signup.dart';
import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart'; 
import 'package:form_field_validator/form_field_validator.dart';
import 'network/token_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Login_ extends StatefulWidget {
  const Login_({super.key});

  @override
  State<Login_> createState() => _Login_State();
}
String? errorMessage = null;
class _Login_State extends State<Login_> {
  final _formkey = GlobalKey<FormState>(); 
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true ;

   void initState() {
    super.initState();
    errorMessage = null; // Khởi tạo lại errorMessage khi màn hình được hiển thị
  }
  Future<void> _handleGoogleSignIn() async {

    try {
      GoogleSignInAccount? googleUser = await GoogleSignInApi.login();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      await GoogleSignInApi.loginWithGoogle(accessToken!);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homeblog_()  ));
    } catch (error) {
      print(error);
    }
  }

  Future<void> _signout() async {
    await GoogleSignInApi.logout();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    final String username = _emailController.text;
    final String password = _passwordController.text;
    try {
      await TokenStorage.fetchToken(username, password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homeblog_()  ));
    } catch (e) {
      print('Failed to fetch token: $e');
      setState(() {
        errorMessage = 'Something wrong!';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    
    //errorMessage ;

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
                        Text(' Welcome back! ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold , color: Color.fromARGB(255, 79, 187, 90)),),
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
                        Text(' Sign in to pick up where you left off. '),
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
                            controller: _emailController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Enter email address !'),
                              EmailValidator(errorText: 'Correct email filled !'),
                            ]),
                            decoration: InputDecoration(
                              hintText: 'Enter email' , 
                              labelText:  'Your email' ,
                              prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 79, 187, 90),), 
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
                              controller: _passwordController,
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
                        // Forgot password and sign up
                        Row(
                          children: <Widget>[
                            Padding( 
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0), 
                                child: TextButton(
                                  child: Text( 'Forgot Password', style: TextStyle(color: Color.fromARGB(255, 79, 187, 90) ),  ),
                                  onPressed:(){
                                    try{
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Change_pass_()  ));
                                    }catch(e){
                                      print(e);
                                    }
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
                                  child: Text( 'new user ?', style: TextStyle(color: Color.fromARGB(255, 79, 187, 90)  ),  ),
                                  onPressed:(){
                                    try{
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_()  ));
                                    }catch(e){
                                      print(e);
                                    }
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
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 79, 187, 90)),
                                ),
                                child: Text( 'Login', style: TextStyle(color: Colors.white,  fontSize:22 ,  ),) ,                                                              
                                onPressed: _submitLogin,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width, 
                            height: 50, 
                          ),
                        ),
                        // Hiển thị thông báo lỗi nếu có
                        if (errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              errorMessage!,
                              style: TextStyle(color: Colors.red),
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
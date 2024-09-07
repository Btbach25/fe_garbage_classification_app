import 'package:fe_garbage_classification_app/blog_screen/home_blog.dart';
import 'package:fe_garbage_classification_app/start_screen/api/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Getusername extends StatefulWidget {
  const Getusername({super.key});

  @override
  State<Getusername> createState() => _GetusernameState();
}

class _GetusernameState extends State<Getusername> {

  final TextEditingController _usernameController = TextEditingController();

  Future<void> _handleInputUsername() async{
    String? username = _usernameController.text;
    try{
      GoogleSignInAccount? googleUser = await GoogleSignInApi.login();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      await GoogleSignInApi.SigninwithGoogle(username,accessToken!);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homeblog_()  ));
    }
    catch(e){
      print(e);
    }
  }

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
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only( left: 25),
                    child: Column(
                      children: <Widget>[
                        Text('Everything is done!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold , color: Color.fromARGB(255, 79, 187, 90)),),
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
                        Text('What should I call you?'),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                          padding: const EdgeInsets.all(31.0),
                          child: TextFormField(
                            controller: _usernameController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Enter your username !'),
                              //EmailValidator(errorText: 'Correct email filled !'),
                            ]),
                            decoration: const InputDecoration(
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
                                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 79, 187, 90)),
                                ),
                                child: Text( 'Enter!', style: TextStyle(color: Colors.white,  fontSize:22 ,  ),) ,                                                              
                                onPressed:_handleInputUsername,
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
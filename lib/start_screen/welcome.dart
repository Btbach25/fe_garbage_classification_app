import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';  
import 'package:fe_garbage_classification_app/start_screen/login.dart';
import 'package:fe_garbage_classification_app/start_screen/signup.dart';
class welcum_ extends StatefulWidget {
  const welcum_({super.key});

  @override
  State<welcum_> createState() => _welcum_State();
}

class _welcum_State extends State<welcum_> {
  DateTime? lastPressed;

  //Method handle pop up
  Future<bool> _onWillPop() async { 
    final DateTime now = DateTime.now();
    if (lastPressed == null || now.difference(lastPressed!) > Duration(seconds: 2)) { //Set the interval to 2 clicks
      lastPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nhấn thêm lần nữa để thoát')),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) { 
    return PopScope( //Pressing back twice will exit the application
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await _onWillPop() ?? false;
        if (context.mounted && shouldPop) {
          await SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
          //Color.fromARGB(255, 28, 113, 57), 
          //Color.fromARGB(255, 79, 187, 90),
        
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image : DecorationImage(
              image : AssetImage('assets/images/welcom_bg.png'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/src_wcpic.png', width: 400,height: 400,),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                // color:  Color(0x4FBB5A),
                                  child: Center(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 79, 187, 90)),
                                      ),
                                      child: Text( 'Get Started !', style: TextStyle(color: Colors.white,  fontSize:22 ,  ),) ,                                                              
                                      onPressed: (){
                                        try{
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_()  ));
                                        }catch(e){
                                        print(e);
                                      }
                                      },
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width, 
                                  height: 50, 
                                ),
                              ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding( 
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0), 
                                        child: Text( 'Already have an account ?', style: TextStyle(color: Colors.black  ),  ),                                                                                                                         
                                  ),
                      Padding( 
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0), 
                                  child: TextButton(
                                    child: Text( 'Login here!', style: TextStyle(color: Color.fromARGB(255, 79, 187, 90) ),  ),
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
                ],
              ),  
            ],
          ),
        ),
      )
    );
  }
}


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
           
            Padding(
              padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('New Post !',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold , color: Color.fromARGB(255, 79, 187, 90)),),
            ),
            
            /*Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Enter email address !'),
                              
                            ]),
                            decoration: InputDecoration(
                              hintText: 'Description' , 
                              //labelText:  'Your email' ,
                              //prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 116, 195, 124),), 
                              //errorStyle: TextStyle(fontSize: 12.0), 
                              
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 79, 187, 90)),
                                borderRadius: BorderRadius.all(Radius.circular(15.0)), 
                              ),
                              
                            ),
                            
                          ),
                        ),*/
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  maxLines: 10,
                  minLines: 7,
                  //expands: true,
                  validator: MultiValidator([
                      RequiredValidator(errorText: 'Enter a description'),]),
                  decoration: InputDecoration(
                    hintText: 'Description',
                     // Adjust the width as needed for your specific layout
                    constraints: BoxConstraints(maxWidth: 500.0), // Adjust as needed
                    border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color.fromARGB(255, 79, 187, 90)),
                    borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), 
                      ),
                    ),
                    onPressed: (){
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                      Icon(Icons.add_a_photo),
                      Text('Add picture'),
                  
                    ],)
                  ),
                )
                
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  child: Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 79, 187, 90)),
                      ),
                    child: Text( 'Create!', style: TextStyle(color: Colors.white,  fontSize:22 ,  ),) ,                                                              
                    onPressed: (){ },
                    ),
                            ),
                    width: MediaQuery.of(context).size.width, 
                    height: 60, 
                  ),
              ),
          ],
        ),
      ),
    );
  }
}
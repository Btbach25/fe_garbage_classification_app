import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {

  final List<CameraDescription> cameras;
  final CameraController controller;
  const CameraPage({
    super.key, 
    required this.cameras,
    required this.controller,
    });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  

  Future<void> _takePicture() async {
    // ... (your code for taking a picture)
  }

  @override
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: widget.controller == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
              
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.lightGreen , 
                        width: 3.0,
                      )
                    ),
                    child: CameraPreview(widget.controller),
                  ),
                ),
              ),



            ],
          ),
    );
  }
}
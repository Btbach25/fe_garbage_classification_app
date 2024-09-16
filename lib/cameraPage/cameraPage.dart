import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
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
  
  Future<void> deleteImage(File imageFile) async {
    try {
      await imageFile.delete();
      print('Ảnh đã được xóa');
    } catch (e) {
      print('Lỗi khi xóa ảnh: $e');
    }
  }
  Future<void> clearTemporaryImages() async {
    final temporaryDirectory = await getTemporaryDirectory();
    final files = temporaryDirectory.listSync();

    for (var file in files) {
      if (file is File && file.path.endsWith('.jpg')) {
        await deleteImage(file);
      }
    }
  }

  Future<void> _takePicture() async {
    try {
    final image = await widget.controller.takePicture();

  // Lưu ảnh vào thư mục tạm thời
    final appDirectory = await getTemporaryDirectory();
    final pictureFile = File('${appDirectory.path}/picture_${DateTime.now()}.jpg');
    await image.saveTo(pictureFile.path);

  // Hiển thị thông báo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Taken photo!')),
    );
    // Hiển thị dialog cho phép người dùng xem ảnh hoặc chia sẻ
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Taken photo'),
        content: Image.file(pictureFile),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              
            },
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              
              Navigator.pop(context);
            },
            child: Text('Analyze this photo'),
          ),
        ],
      ),
    );
  } catch (e) {
    print('Lỗi khi chụp ảnh: $e');
    // Hiển thị thông báo lỗi cho người dùng
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  }

  @override
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera' ,  style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
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
                    width: 350,
                    height: 500,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    
                    onPressed: clearTemporaryImages,
                    child: Icon(Icons.delete_forever_outlined),                  
                  ),
                  FloatingActionButton.large(
                    onPressed: _takePicture,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50), // Bán kính góc bo tròn
                    ), 
                    child: Icon(Icons.camera_alt_outlined),                  
                  ),
                  SizedBox(
                      width: 40,
                      height: 40,
                  ),

                ],
              ),
            ],
          ),
    );
  }
}
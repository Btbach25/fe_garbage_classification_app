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
      SnackBar(content: Text('Ảnh đã được lưu')),
    );
    // Hiển thị dialog cho phép người dùng xem ảnh hoặc chia sẻ
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ảnh đã được lưu'),
        content: Image.file(pictureFile),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              
            },
            child: Text('Đóng'),
          ),
          TextButton(
            onPressed: () {
              
              Navigator.pop(context);
            },
            child: Text('Tích phân'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    
                    onPressed: clearTemporaryImages,
                    child: Icon(Icons.delete),                  
                  ),
                  FloatingActionButton(
                    onPressed: _takePicture,
                    child: Icon(Icons.camera),                  
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
import 'package:fe_garbage_classification_app/blog_screen/home_blog.dart';
import 'package:fe_garbage_classification_app/profile_screen/api/getProfile.dart';
import 'package:fe_garbage_classification_app/profile_screen/component/Information_widget.dart';
import 'package:fe_garbage_classification_app/profile_screen/models/Profile.dart';
import 'package:flutter/material.dart';

class MainProfiles extends StatefulWidget {
  final Profile? profile;
  const MainProfiles({
    super.key,
    required this.profile,
  });

  @override
  State<StatefulWidget> createState() => _mainProfiles();
}

class _mainProfiles extends State<MainProfiles>{
  Profile _profile = Profile();

  @override
  void initState() {
    _loadProfile();
    super.initState();
  }
  void _loadProfile() async {
  try {
    setState(() {
      _profile = widget.profile!;
    });
  } catch (e) {
    print('Error loading profile: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:  myBlogs(myprofile: _profile,isProfile: true,),


    );
  }
}

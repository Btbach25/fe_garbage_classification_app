import 'package:fe_garbage_classification_app/profile_screen/api/getProfile.dart';
import 'package:fe_garbage_classification_app/profile_screen/component/Information_widget.dart';
import 'package:fe_garbage_classification_app/profile_screen/models/Profile.dart';
import 'package:flutter/material.dart';

class MainProfiles extends StatefulWidget {
  const MainProfiles({super.key});

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

    final profile = await ProfileAPI.getProfile(1);

    setState(() {
      _profile = profile;
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
      body: InforWidget(profile: _profile)
      /*Column(
        children: [
          InforWidget(profile: _profile),
        ],
      ),*/
    );
  }
}

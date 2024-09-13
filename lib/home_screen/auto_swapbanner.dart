import 'dart:async';
import 'package:flutter/material.dart';

class AutoSwapBanner extends StatefulWidget {
  final List<String> imageUrls;

  AutoSwapBanner({required this.imageUrls});

  @override
  _AutoSwapBannerState createState() => _AutoSwapBannerState();
}

class _AutoSwapBannerState extends State<AutoSwapBanner> {
  int _currentIndex = 0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentIndex < widget.imageUrls.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imageUrls.length,
      itemBuilder: (context, index) {
        return Image.network(
          widget.imageUrls[index],
          fit: BoxFit.cover, 
        );
      },
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
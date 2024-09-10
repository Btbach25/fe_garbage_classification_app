import 'dart:async';
import 'package:flutter/material.dart';

class AutoSwapBanner extends StatefulWidget {
  final List<String> imageUrls;
  final Duration duration;

  const AutoSwapBanner({Key? key, required this.imageUrls, this.duration = const Duration(seconds: 3)}) : super(key: key);

  @override
  _AutoSwapBannerState createState() => _AutoSwapBannerState();
}

class _AutoSwapBannerState extends State<AutoSwapBanner> {
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.imageUrls.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.imageUrls.length,
      itemBuilder: (context, index) {
        return Image.network(widget.imageUrls[index], fit: BoxFit.cover);
      },
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:systemaltruism/services/get_images.dart';
import 'package:systemaltruism/widgets/user_image.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late List<String> _imageUrls;
  late List<String> _renderedUrls;
  late int _currentIndex;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _imageUrls = [];
    _renderedUrls = [];
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    try {
      final List<String> images = await GetImages().getImage();
      _imageUrls.addAll(images);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: _imageUrls.length * 2),
          content: const Text(
            "Loading...",
          ),
        ),
      );
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_currentIndex < _imageUrls.length) {
          setState(() {
            _renderedUrls.add(_imageUrls[_currentIndex]);
            _currentIndex++;
          });
        } else {
          _timer.cancel();
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 10),
            content: Text(
              "Completed!!",
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$e"),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Face Search App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _renderedUrls.length + 1, // Add 1 for the loading indicator
        itemBuilder: (BuildContext context, int index) {
          if (index < _renderedUrls.length) {
            return UserImage(img: _renderedUrls[index]);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Show loading indicator for the next item
        },
      ),
    );
  }
}

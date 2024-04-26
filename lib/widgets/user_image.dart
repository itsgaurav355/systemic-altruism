import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String img;
  const UserImage({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        surfaceTintColor: Colors.white,
        child: Image.network(img),
      ),
    );
  }
}

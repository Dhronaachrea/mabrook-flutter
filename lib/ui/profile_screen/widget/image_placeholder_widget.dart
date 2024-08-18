import 'package:flutter/material.dart';
import 'package:mabrook/utility/colors.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      child: Icon(
        Icons.person,
        color: MabrookColor.lightGrey,
        size: 70,
      ),
      backgroundColor: MabrookColor.warmGrey,
      radius: 55.0,
    );
  }
}
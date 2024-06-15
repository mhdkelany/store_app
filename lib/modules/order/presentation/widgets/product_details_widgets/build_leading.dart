import 'package:flutter/material.dart';
import 'package:store/shared/style/icon_broken.dart';

class BuildLeading extends StatelessWidget {
  const BuildLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.8),
        radius: 18.0,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            IconBroken.Arrow___Right_2,
            color: Colors.black,
            size: 18,
          ),
        ),
      ),
    );
  }
}

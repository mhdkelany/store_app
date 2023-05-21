import 'package:flutter/material.dart';

class BuildFallBackCart extends StatelessWidget {
  const BuildFallBackCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.remove_shopping_cart,
              color: Colors.grey[200],
              size: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'السلة فارغة',
              style: TextStyle(
                  color: Colors.grey[200], fontSize: 30),
            ),
          ],
        ));
  }
}

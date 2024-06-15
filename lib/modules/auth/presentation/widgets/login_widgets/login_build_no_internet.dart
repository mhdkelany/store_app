import 'package:flutter/material.dart';

class LoginBuildNoInternet extends StatelessWidget {
  const LoginBuildNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/images/no_internet.png'),
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'لا يوجد اتصال بالانترنت !'
                    'تأكد من اتصالك ثم اعد المحاولة',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 15.0,
              ),
              CircularProgressIndicator()
            ],
          ),
        ));
  }
}

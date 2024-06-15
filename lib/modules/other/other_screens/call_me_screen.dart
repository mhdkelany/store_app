import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store/shared/style/color.dart';
import 'package:url_launcher/url_launcher.dart';

class CallMeScreen extends StatelessWidget {
  const CallMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Text('اتصل بنا'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                FontAwesomeIcons.phone,
              size: 90,
              color: ColorsApp.primaryColor,
            ),
            SizedBox(height: 20,),
            Text(
                'تواصل معنا على الأرقام التالية : ',
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'tajawal-light',
                fontSize: 20
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5),width: 1)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.squarePhone,
                        color: ColorsApp.primaryColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.08,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Icon(Icons.phone,color: Colors.grey,size: 16,),
                                SizedBox(width: 5,),
                                Text(
                                    '962781651884+',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width*0.72,
                              height: 1,
                              color: Colors.grey,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.phone,color: Colors.grey,size: 16,),
                                  SizedBox(width: 5,),
                                  Text(
                                      '963935726156+',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: ()async{
                  launchUrl(Uri.parse('https://www.facebook.com/طلبيات-_لتزويد-المحلات-بالبضائع-107042805444600/'),mode: LaunchMode.inAppWebView,);
                 await canLaunchUrl(Uri.parse('https://www.facebook.com/طلبيات-_لتزويد-المحلات-بالبضائع-107042805444600/'));
              },
              child: Icon(
                  FontAwesomeIcons.facebook,
                size: 60,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}

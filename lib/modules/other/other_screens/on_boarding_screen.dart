import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/modules/other/other_screens/choice_user.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/shared/style/color.dart';

class Model{
  String image;
  String title;
  String body;
  Model({required this.body,required this.image,required this.title});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageControl=PageController();
  List<Model> boarding=[
    Model(
        body: 'اطلب ماتحتاجه من منتجات باسعار مناسبة وبأقل تكاليف التوصيل',
        image: 'assets/images/firstimg.png',
        title: 'هل انت صاحب محل؟'
    ),
    Model(
        body: 'اعرض منتجاتك على التطبيق مجاناً وزد من ارباحك من خلال زيادة مبيعاتك',
        image: 'assets/images/secondimg.png',
        title: 'هل انت تاجر؟'
    ),
    Model(
        body: 'انشئ حسابك وقم بتسجيل الدخول للحصول على المزايا',
        image: 'assets/images/thriedimg.png',
        title: 'ابدأ الان'
    ),

  ];
  bool isLast=false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index){
                    if(boarding.length-1==index)
                      {
                        setState(() {
                          isLast=true;
                        });
                      }
                    else{
                      isLast=false;
                      setState(() {

                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  controller:pageControl ,
                    itemBuilder:(context, index)=>buildBoardItem(boarding[index]),
                  itemCount: 3,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageControl,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10.0,
                        dotWidth: 10.0,
                        expansionFactor: 4.0,
                        activeDotColor: primaryColor,
                        spacing: 5
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                      onPressed: ()
                      {
                        if(isLast)
                          {
                            CacheHelper.putData(key: 'onBoard', value: isLast).then((value) {
                              if(value)
                                {
                                  navigateToEnd(context, ChoiceUser());
                                }
                            });
                          }
                        pageControl.nextPage(
                            duration: Duration(
                              milliseconds: 500,
                            ),
                            curve: Curves.fastOutSlowIn
                        );
                      },
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),
                    backgroundColor: primaryColor,
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildBoardItem(Model model)=>Column(
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
            color: primaryColor,
            fontSize: 24.0
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/cubit.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/edit_profile_screen.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/style/color.dart';

import '../shared/components/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return  ConditionalBuilder(
          condition: StoreAppCubit.get(context).userInformation!=null,
          builder: (context)=>Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.33,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height*0.25,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)
                                ),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/images/coverprof.png')
                                )
                            ),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/prof.png',),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${StoreAppCubit.get(context).userInformation!.name}',
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${StoreAppCubit.get(context).userInformation!.phone}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey.withOpacity(0.1)
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${StoreAppCubit.get(context).userInformation!.address}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'tajawal-light'
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: (){
                      navigateTo(context,EditProfileScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey.withOpacity(0.1)
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '?????????? ????????????',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'tajawal-light'
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: (){
                      logOut(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey.withOpacity(0.1)
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.login_outlined,
                              color: primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '?????????? ????????',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'tajawal-light'
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );

      },
    );
  }
}

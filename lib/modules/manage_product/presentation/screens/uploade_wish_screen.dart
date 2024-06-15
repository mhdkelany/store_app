import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_cubit.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_state.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/components/constansts/constansts.dart';
import 'package:store/shared/components/glowing_button/glowing_button.dart';

import '../../../../shared/style/color.dart';
import '../../../auth/login/login_cubit/states.dart';

class UploadWishScreen extends StatelessWidget {
  var wishController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ManageProductCubit,ManageProductState>(
        listener: (context,state)
        {
          if(state is CheckSocketState)
            {
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوحد اتصال بالأنترنت'), Colors.amberAccent, Duration(seconds: 3)));

            }
          if(state is PostWishSuccessState)
            {
              if(!state.updateProductEntity.status)
                {
                  ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لقد قمت بادخال هذا المنتج مسبقاً بالفعل'), Colors.amberAccent, Duration(seconds: 3)));
                }
              else{
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('تمت عملية الادخال،سوف نتواصل معك قريباً لتلبية طلبك'), primaryColor, Duration(seconds: 3)));
              }
            }
        },
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(

            ),
            body: Form(
              key: formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/wishs.png'),
                          fit: BoxFit.cover,
                          height: 100.h,
                        ),
                        SizedBox(
                          height: 30.0.h,
                        ),
                        Text(
                          'يمكنك الان من ارسال المنتجات التي لم تجدها في التطبيق.',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'tajawal-light',
                              fontSize: 16.sp
                          ),
                        ),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        defaultTextFromField(
                            hintText: 'محارم',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isShow: false,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            controller: wishController,
                            text: 'اسم المنتج',
                            prefix: Icons.shopping_cart_outlined,
                            inputType: TextInputType.text,
                            validate: (String value)
                            {
                              if(value.trim().isEmpty)
                                return 'يجب ان لا يكون فارغا';
                              if(value.trim().length<2)
                                return 'يجب ان تكون القيمة اكبر من 1';
                              if(value.trim().length>15)
                                return 'يجب ان تكون القيمة اقل من 15';
                              // validator(value, 1, 15, 'product');
                            }
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        if(token!=null)
                        defaultButton(
                          function:state is PostWishLoadingState?null: ()
                          {
                            if(formKey.currentState!.validate())
                            {
                              ManageProductCubit.get(context).postWish( wishController.text);
                            }
                          },
                          widget:state is PostWishLoadingState?  Row(
                            children: [
                              Text(
                                'جاري الإرسال...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ): Text(
                            'إرسال',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        if(token==null)
                          GlowingButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

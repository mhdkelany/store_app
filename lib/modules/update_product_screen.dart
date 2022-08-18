import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/home_model.dart';

import '../layout/cubit/cubit.dart';
import '../shared/components/components.dart';
import '../shared/components/constansts/constansts.dart';
import '../shared/style/color.dart';

class UpdateProductScreen extends StatelessWidget {
  Products products;
  String ?idCategory;
  File file=File('/data/user/0/com.storeapp.store/cache/image_picker5371963979232859410.jpg');
  RegExp _regExp = RegExp(r'^[0-9]+$');
  RegExp reg = RegExp(r'^\d{0,8}(\.\d{1,4})?$');
  UpdateProductScreen({required this.products});
  var productNameController=TextEditingController();
  var descriptionController=TextEditingController();
  var priceController=TextEditingController();
  var quantityController=TextEditingController();
  var shortDescriptionController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    productNameController.text=products.name!;
    descriptionController.text=products.longDescription!;
    priceController.text=products.price.toString();
    quantityController.text=products.quantity!;
    shortDescriptionController.text=products.shortDescription!;
    return BlocConsumer<StoreAppCubit,StoreAppStates>(
      listener: (context,state)
      {
        if(state is CheckSocketState)
          {
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));
          }
      },
      builder: (context,state)
      {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'تعديل منتج',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'tajawal-light'
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultTextFromField(
                          prefixIconColor: fourColor,
                          border2: OutlineInputBorder(
                              borderSide: BorderSide(color: fourColor,width: 1),
                              borderRadius: BorderRadius.circular(20.0,)
                          ),
                          focusColor: fourColor,
                          fillColor: fourColor,
                          hoverColor: fourColor,
                          hintText: 'اسم المنتج',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isShow: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          controller:productNameController,
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
                        height: 15.0,
                      ),
                      DropdownButtonFormField<dynamic>(
                        items:StoreAppCubit.get(context).categoriesModel!=null? StoreAppCubit.get(context).categoriesModel!.data.map((e) =>DropdownMenuItem(child: Text('${e.name}'),value:e.idCate ,onTap: (){print(e.idCate);},)).toList():[].map((e) => DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                        onChanged: (value)
                        {
                          StoreAppCubit.get(context).choiceFromCategory(value);
                          idCategory=value;
                          print(value.toString());

                        },
                        onTap: (){

                        },
                        value: StoreAppCubit.get(context).category,
                        borderRadius: BorderRadius.circular(20.0),
                        decoration: InputDecoration(
                            border: InputBorder.none
                        ),
                        hint: Text(StoreAppCubit.get(context).categoriesModel!=null?'اختر القسم':'يوجد خطأ'),
                        validator: (value)
                        {

                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFromField(
                          prefixIconColor: fourColor,
                          border2: OutlineInputBorder(
                              borderSide: BorderSide(color: fourColor,width: 1),
                              borderRadius: BorderRadius.circular(20.0,)
                          ),
                          focusColor: fourColor,
                          fillColor: fourColor,
                          hoverColor: fourColor,
                          hintText: 'مثلاً لون المنتج',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isShow: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          controller:shortDescriptionController,
                          text: 'وصف صغير',
                          prefix: Icons.short_text,
                          inputType: TextInputType.text,
                          validate: (String value)
                          {
                            if(value.trim().isEmpty)
                              return 'يجب ان لا يكون فارغا';
                            if(value.trim().length<2)
                              return 'يجب ان تكون القيمة اكبر من 1';
                            if(value.trim().length>25)
                              return 'يجب ان تكون القيمة اقل من 25';
                            // validator(value, 1, 15, 'product');
                          }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFromField(
                        maxLine: 3,
                          prefixIconColor: fourColor,
                          border2: OutlineInputBorder(
                              borderSide: BorderSide(color: fourColor,width: 1),
                              borderRadius: BorderRadius.circular(20.0,)
                          ),
                          focusColor: fourColor,
                          fillColor: fourColor,
                          hoverColor: fourColor,
                          hintText: 'مثلاً كمية القطع في الكرتونة',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isShow: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          controller:descriptionController,
                          text: 'وصف كبير',
                          prefix: Icons.description,
                          inputType: TextInputType.text,
                          validate: (String value)
                          {
                            if(value.trim().isEmpty)
                              return 'يجب ان لا يكون فارغا';
                            if(value.trim().length<2)
                              return 'يجب ان تكون القيمة اكبر من 1';
                            if(value.trim().length>150)
                              return 'يجب ان تكون القيمة اقل من 150';
                            // validator(value, 1, 15, 'product');
                          }
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultTextFromField(
                          prefixIconColor: fourColor,
                          border2: OutlineInputBorder(
                              borderSide: BorderSide(color: fourColor,width: 1),
                              borderRadius: BorderRadius.circular(20.0,)
                          ),
                          focusColor: fourColor,
                          fillColor: fourColor,
                          hoverColor: fourColor,
                          hintText: '150 دينار',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isShow: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          controller:priceController,
                          text: 'السعر',
                          prefix: Icons.price_check,
                          inputType: TextInputType.numberWithOptions(),
                          validate: (String value)
                          {
                            if(!reg.hasMatch(value))
                              {
                                return'يجب ادخال رقم';
                              }
                            if(value.trim().isEmpty)
                              return 'يجب ان لا يكون فارغا';
                            if(value.trim().length>6)
                              return 'يجب ان تكون القيمة اقل من 6';
                            // validator(value, 1, 15, 'product');
                          }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFromField(
                          prefixIconColor: fourColor,
                          border2: OutlineInputBorder(
                              borderSide: BorderSide(color: fourColor,width: 1),
                              borderRadius: BorderRadius.circular(20.0,)
                          ),
                          focusColor: fourColor,
                          fillColor: fourColor,
                          hoverColor: fourColor,
                          hintText: '5',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isShow: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          controller:quantityController,
                          text: 'الكمية',
                          prefix: Icons.queue,
                          inputType: TextInputType.numberWithOptions(),
                          validate: (String value)
                          {
                            if(!_regExp.hasMatch(value))
                              {
                                return 'يجب ادخال رقم';
                              }
                            if(value.trim().isEmpty)
                              return 'يجب ان لا يكون فارغا';

                            if(value.trim().length>6)
                              return 'يجب ان تكون القيمة اقل من 6';
                            // validator(value, 1, 15, 'product');
                          }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      OutlinedButton(
                        onPressed: ()
                        {
                          StoreAppCubit.get(context).choiceImage();
                        },
                        child: Text(
                            'اختر صورة للمنتج'
                        ),),
                      if(StoreAppCubit.get(context).productImage!=null)
                        Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            Image(
                              image: FileImage(StoreAppCubit.get(context).productImage!),
                              fit: BoxFit.cover,
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              child: IconButton(onPressed: ()
                              {
                                print(StoreAppCubit.get(context).productImage);
                                StoreAppCubit.get(context).removeImage();
                              },icon: Icon(Icons.highlight_remove),),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultButton(
                          function:state is UpdateProductForUserLoadingState?null: ()
                          {
                            print(StoreAppCubit.get(context).productImage);
                            if(formKey.currentState!.validate())
                            {
                              if(idCategory!=null) {
                                if (StoreAppCubit
                                    .get(context)
                                    .productImage != null) {
                                  StoreAppCubit.get(context).updateProduct(
                                      data: {
                                        'name': productNameController.text,
                                        'shortDescription': shortDescriptionController
                                            .text,
                                        'longDescription': descriptionController
                                            .text,
                                        'price': priceController.text,
                                        'quantity': quantityController.text,
                                        'token': token,
                                        'idCategory': idCategory,
                                        'idProduct': products.idProduct
                                      },
                                      path: StoreAppCubit
                                          .get(context)
                                          .productImage!,
                                    context: context
                                  );
                                }
                                else {
                                  StoreAppCubit.get(context).updateProduct(
                                      data: {
                                        'name': productNameController.text,
                                        'shortDescription': shortDescriptionController
                                            .text,
                                        'longDescription': descriptionController
                                            .text,
                                        'price': priceController.text,
                                        'quantity': quantityController.text,
                                        'token': token,
                                        'idCategory': idCategory,
                                        'idProduct': products.idProduct
                                      },
                                      path: null,
                                    context: context
                                  );
                                  print(file.path);
                                }
                              }
                              else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('يجب اختيار قسم'), Colors.red, Duration(seconds: 3)));
                                }
                            }
                          },
                          widget: state is UpdateProductForUserLoadingState?Text('جاري التعديل...',style: TextStyle(color: Colors.white,fontSize: 20)):Text('تعديل المنتج',style: TextStyle(color: Colors.white,fontSize: 20),)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/categoryandfavorite/domain/entity/products_of_categories.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_cubit.dart';
import 'package:store/modules/categoryandfavorite/presentation/controller/favorite_and_category_state.dart';
import 'package:store/modules/manage_product/domain/manage_product_usecase/add_product_usecase.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_cubit.dart';
import 'package:store/modules/manage_product/presentation/controller/manage_product_state.dart';

import '../../../../layout/cubit/cubit.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constansts/constansts.dart';
import '../../../../shared/style/color.dart';
import '../../../auth/login/login_cubit/states.dart';

class UpdateProductScreen extends StatelessWidget {
  Product products;
  String? idCategory;
  File file = File(
      '/data/user/0/com.storeapp.store/cache/image_picker5371963979232859410.jpg');
  RegExp _regExp = RegExp(r'^[0-9]+$');
  RegExp reg = RegExp(r'^\d{0,8}(\.\d{1,4})?$');

  UpdateProductScreen({required this.products});

  var productNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();
  var shortDescriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? idSupOfCategory;

  @override
  Widget build(BuildContext context) {
    productNameController.text = products.name!;
    descriptionController.text = products.longDescription!;
    priceController.text = products.price.toStringAsFixed(2).toString();
    quantityController.text = products.quantity!;
    shortDescriptionController.text = products.shortDescription!;
    return BlocConsumer<ManageProductCubit, ManageProductState>(
      listener: (context, state) {
        if (state is CheckSocketState) {
          ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
              Text('لا يوجد اتصال باﻷنترنت'),
              Colors.amber,
              Duration(seconds: 5)));
        }
          if(state is UpdateProductForUserSuccessState)
            {
              if(state.updateProductEntity.status)
                {
                  ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                      Text(state.updateProductEntity.message,style: TextStyle(fontSize: 14,fontFamily: 'tajawal-light')), Colors.green,
                      Duration(seconds: 3)));
                }else{
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                    Text('لم يتم التعديل على المنتج',style: TextStyle(fontSize: 14,fontFamily: 'tajawal-light'),), Colors.red,
                    Duration(seconds: 3)));
              }
            }

      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'تعديل منتج',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'tajawal-light'),
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
                              borderSide:
                                  BorderSide(color: fourColor, width: 1),
                              borderRadius: BorderRadius.circular(
                                20.0,
                              )),
                          focusColor: fourColor,
                          fillColor: fourColor,
                          hoverColor: fourColor,
                          hintText: 'اسم المنتج',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isShow: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          controller: productNameController,
                          text: 'اسم المنتج',
                          prefix: Icons.shopping_cart_outlined,
                          inputType: TextInputType.text,
                          validate: (String value) {
                            if (value.trim().isEmpty)
                              return 'يجب ان لا يكون فارغا';
                            if (value.trim().length < 2)
                              return 'يجب ان تكون القيمة اكبر من 1';
                            if (value.trim().length > 80)
                              return 'يجب ان تكون القيمة اقل من 80';
                            // validator(value, 1, 15, 'product');
                          }),
                      SizedBox(
                        height: 15.0,
                      ),
                      DropdownButtonFormField<dynamic>(
                        dropdownColor: Colors.white,
                        items: FavoriteAndCategoryCubit.get(context)
                                    .categoryEntity !=
                                null
                            ? FavoriteAndCategoryCubit.get(context)
                                .categoryEntity!
                                .cateData
                                .map((e) => DropdownMenuItem(
                                      child: Text('${e.name}'),
                                      value: e.idCate,
                                      onTap: () {
                                        print(e.idCate);
                                      },
                                    ))
                                .toList()
                            : []
                                .map((e) => DropdownMenuItem(
                                      child: Text('$e'),
                                      value: e,
                                    ))
                                .toList(),
                        onChanged: (value) {
                          StoreAppCubit.get(context).choiceFromCategory(value);
                          idCategory = value;
                          FavoriteAndCategoryCubit.get(context)
                              .getSubCate( idCategory!);
                        },
                        onTap: () {},
                        value: idCategory,
                        borderRadius: BorderRadius.circular(20.0),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15)),
                        hint: Text(FavoriteAndCategoryCubit.get(context)
                                    .categoryEntity !=
                                null
                            ? 'اختر القسم'
                            : 'يوجد خطأ'),
                        validator: (value) {},
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      BlocBuilder<FavoriteAndCategoryCubit,
                          FavoriteAndCategoryState>(
                        builder: (context, state) {
                          return DropdownButtonFormField<dynamic>(
                            dropdownColor: Colors.white,
                            items: FavoriteAndCategoryCubit.get(context)
                                        .subCategoryEntity !=
                                    null
                                ? FavoriteAndCategoryCubit.get(context)
                                    .subCategoryEntity!
                                    .data
                                    .map((e) => DropdownMenuItem(
                                          child: Text('${e.name}'),
                                          value: e.id,
                                        ))
                                    .toList()
                                : []
                                    .map((e) => DropdownMenuItem(
                                          child: Text('$e'),
                                          value: e,
                                        ))
                                    .toList(),
                            onChanged: (value) {
                              StoreAppCubit.get(context)
                                  .choiceFromSubCategory(value);
                              idSupOfCategory = value;
                            },
                            value: idSupOfCategory,
                            borderRadius: BorderRadius.circular(20.0),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15)),
                            hint: Text(FavoriteAndCategoryCubit.get(context)
                                        .categoryEntity !=
                                    null
                                ? 'اختر الفئة'
                                : 'يوجد خطأ'),
                          );
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFromField(
                          prefixIconColor: fourColor,
                          border2: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: fourColor, width: 1),
                              borderRadius: BorderRadius.circular(
                                20.0,
                              )),
                          focusColor: fourColor,
                          fillColor: fourColor,
                          hoverColor: fourColor,
                          hintText: 'مثلاً لون المنتج',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isShow: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          controller: shortDescriptionController,
                          text: 'وصف صغير',
                          prefix: Icons.short_text,
                          inputType: TextInputType.text,
                          validate: (String value) {
                            if (value.trim().isEmpty)
                              return 'يجب ان لا يكون فارغا';
                            if (value.trim().length < 2)
                              return 'يجب ان تكون القيمة اكبر من 1';
                            if (value.trim().length > 25)
                              return 'يجب ان تكون القيمة اقل من 25';
                            // validator(value, 1, 15, 'product');
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFromField(
                          maxLine: 3,
                          prefixIconColor: fourColor,
                          border2: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: fourColor, width: 1),
                              borderRadius: BorderRadius.circular(
                                20.0,
                              )),
                          focusColor: fourColor,
                          fillColor: fourColor,
                          hoverColor: fourColor,
                          hintText: 'مثلاً كمية القطع في الكرتونة',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isShow: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          controller: descriptionController,
                          text: 'وصف كبير',
                          prefix: Icons.description,
                          inputType: TextInputType.text,
                          validate: (String value) {
                            if (value.trim().isEmpty)
                              return 'يجب ان لا يكون فارغا';
                            if (value.trim().length < 2)
                              return 'يجب ان تكون القيمة اكبر من 1';
                            if (value.trim().length > 150)
                              return 'يجب ان تكون القيمة اقل من 150';
                            // validator(value, 1, 15, 'product');
                          }),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultTextFromField(
                          prefixIconColor: fourColor,
                          border2: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: fourColor, width: 1),
                              borderRadius: BorderRadius.circular(
                                20.0,
                              )),
                          focusColor: fourColor,
                          fillColor: fourColor,
                          hoverColor: fourColor,
                          hintText: '150 دينار',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isShow: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          controller: priceController,
                          text: 'السعر',
                          prefix: Icons.price_check,
                          inputType: TextInputType.numberWithOptions(),
                          validate: (String value) {
                            if (!reg.hasMatch(value)) {
                              return 'يجب ادخال رقم';
                            }
                            if (value.trim().isEmpty)
                              return 'يجب ان لا يكون فارغا';
                            if (value.trim().length > 6)
                              return 'يجب ان تكون القيمة اقل من 6';
                            // validator(value, 1, 15, 'product');
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFromField(
                          prefixIconColor: fourColor,
                          border2: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: fourColor, width: 1),
                              borderRadius: BorderRadius.circular(
                                20.0,
                              )),
                          focusColor: fourColor,
                          fillColor: fourColor,
                          hoverColor: fourColor,
                          hintText: '5',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isShow: false,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          controller: quantityController,
                          text: 'الكمية',
                          prefix: Icons.queue,
                          inputType: TextInputType.numberWithOptions(),
                          validate: (String value) {
                            if (!_regExp.hasMatch(value)) {
                              return 'يجب ادخال رقم';
                            }
                            if (value.trim().isEmpty)
                              return 'يجب ان لا يكون فارغا';

                            if (value.trim().length > 6)
                              return 'يجب ان تكون القيمة اقل من 6';
                            // validator(value, 1, 15, 'product');
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          ManageProductCubit.get(context).choiceImage();
                        },
                        child: Text('اختر صورة للمنتج'),
                      ),
                      if (ManageProductCubit.get(context).productImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            Image(
                              image: FileImage(
                                  ManageProductCubit.get(context).productImage!),
                              fit: BoxFit.cover,
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              child: IconButton(
                                onPressed: () {
                                  print(
                                      ManageProductCubit.get(context).productImage);
                                  ManageProductCubit.get(context).removeImage();
                                },
                                icon: Icon(Icons.highlight_remove),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultButton(
                          function: state is UpdateProductForUserLoadingState
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    if (idCategory != null &&
                                        idSupOfCategory != null) {
                                      if (ManageProductCubit.get(context)
                                              .productImage !=
                                          null) {
                                        ManageProductCubit.get(context)
                                            .updateProduct(AddProductParameters(context: context, data: {
                                          'name':
                                          productNameController.text,
                                          'shortDescription':
                                          shortDescriptionController
                                              .text,
                                          'longDescription':
                                          descriptionController.text,
                                          'price': priceController.text,
                                          'quantity':
                                          quantityController.text,
                                          'token': token,
                                          'idCategory': idSupOfCategory,
                                          'idProduct': products.idProduct
                                        }, file: ManageProductCubit.get(context)
                                            .productImage!));
                                      } else {
                                        ManageProductCubit.get(context)
                                            .updateProduct(AddProductParameters(context: context, data: {
                                          'name': productNameController.text,
                                          'shortDescription':
                                          shortDescriptionController.text,
                                          'longDescription':
                                          descriptionController.text,
                                          'price': priceController.text,
                                          'quantity': quantityController.text,
                                          'token': token,
                                          'idCategory': idSupOfCategory,
                                          'idProduct': products.idProduct
                                        }, file: null));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(buildSnackBar(
                                              Text('يجب اختيار قسم'),
                                              Colors.red,
                                              Duration(seconds: 3)));
                                    }
                                  }
                                },
                          widget: state is UpdateProductForUserLoadingState
                              ? Text('جاري التعديل...',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))
                              : Text(
                                  'تعديل المنتج',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
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

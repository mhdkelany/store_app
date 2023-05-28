import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/modules/categoryandfavorite/cubit/cubit.dart';
import 'package:store/modules/categoryandfavorite/cubit/states.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/style/color.dart';

import '../layout/cubit/cubit.dart';
import '../shared/components/constansts/constansts.dart';
var productNameController = TextEditingController();
var descriptionController = TextEditingController();
var priceController = TextEditingController();
var quantityController = TextEditingController();
var shortDescriptionController = TextEditingController();
class AddProductScreen extends StatelessWidget {
  int? hexColor;
  List colors = [];
  RegExp reg = RegExp(r'^\d{0,8}(\.\d{1,4})?$');
  RegExp _regExp = RegExp(r'^[0-9]+$');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    String? idCategory;
    String? idSupOfCategory;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(
                StoreAppCubit.get(context).isOpenDrawer ? 40 : 0.0)),
        transform: Matrix4.translationValues(StoreAppCubit.get(context).xOffset,
            StoreAppCubit.get(context).yOffset, 0)
          ..scale(StoreAppCubit.get(context).scaleFactor),
        duration: Duration(milliseconds: 250),
        child: Form(
          key: formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        StoreAppCubit.get(context).isOpenDrawer
                            ? IconButton(
                                onPressed: () {
                                  StoreAppCubit.get(context).changeDrawer();
                                  print('s');
                                },
                                icon: Icon(Icons.arrow_back_ios))
                            : IconButton(
                                onPressed: () {
                                  StoreAppCubit.get(context).changeDrawer();
                                },
                                icon: Icon(Icons.menu)),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'إضافة منتج',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'tajawal-light'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFromField(
                        prefixIconColor: fourColor,
                        border2: OutlineInputBorder(
                            borderSide: BorderSide(color: fourColor, width: 1),
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
                          if (value.trim().length > 15)
                            return 'يجب ان تكون القيمة اقل من 15';
                          // validator(value, 1, 15, 'product');
                        }),
                    SizedBox(
                      height: 15.0,
                    ),
                    BlocBuilder<CategoriesAndFavoriteCubit,
                        CategoriesAndFavoriteState>(
                      builder: (context, state) {
                        return DropdownButtonFormField<dynamic>(
                          items: CategoriesAndFavoriteCubit.get(context)
                                      .categoriesModel !=
                                  null
                              ? CategoriesAndFavoriteCubit.get(context)
                                  .categoriesModel!
                                  .data
                                  .map((e) => DropdownMenuItem(
                                        child: Text('${e.name}'),
                                        value: e.idCate,
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
                                .choiceFromCategory(value);
                            idCategory = value;
                            CategoriesAndFavoriteCubit.get(context)
                                .getSubOfCategory(id: idCategory!);
                          },
                          value: StoreAppCubit.get(context).category,
                          borderRadius: BorderRadius.circular(20.0),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15)),
                          hint: Text(CategoriesAndFavoriteCubit.get(context)
                                      .categoriesModel !=
                                  null
                              ? 'اختر القسم'
                              : 'يوجد خطأ'),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    BlocBuilder<CategoriesAndFavoriteCubit,
                        CategoriesAndFavoriteState>(
                      builder: (context, state) {
                        return DropdownButtonFormField<dynamic>(
                          items: CategoriesAndFavoriteCubit.get(context)
                                      .subCategoryModel !=
                                  null
                              ? CategoriesAndFavoriteCubit.get(context)
                                  .subCategoryModel!
                                  .dataOfSubCategory
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
                          value: StoreAppCubit.get(context).subCategory,
                          borderRadius: BorderRadius.circular(20.0),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15)),
                          hint: Text(CategoriesAndFavoriteCubit.get(context)
                                      .categoriesModel !=
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
                            borderSide: BorderSide(color: fourColor, width: 1),
                            borderRadius: BorderRadius.circular(
                              20.0,
                            )),
                        focusColor: fourColor,
                        fillColor: fourColor,
                        hoverColor: fourColor,
                        hintText: 'مثلاً للون المنتج',
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
                            borderSide: BorderSide(color: fourColor, width: 1),
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
                            borderSide: BorderSide(color: fourColor, width: 1),
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
                          // if(int.tryParse(value)!>0)
                          //   return 'يجب ان تكون القيمة اكبر من الصفر';
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
                            borderSide: BorderSide(color: fourColor, width: 1),
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
                          // if(int.tryParse(value)!>0)
                          //   return 'يجب ان تكون القيمة اكبر من الصفر';
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
                    BlocBuilder<StoreAppCubit, StoreAppStates>(
                      builder: (context, state) {
                        return OutlinedButton(
                          onPressed: () {
                            StoreAppCubit.get(context).choiceImage();
                          },
                          child: Text('اختر صورة للمنتج'),
                        );
                      },
                    ),
                    if (StoreAppCubit.get(context).productImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: [
                          Image(
                            image: FileImage(
                                StoreAppCubit.get(context).productImage!),
                            fit: BoxFit.cover,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            child: IconButton(
                              onPressed: () {
                                print(StoreAppCubit.get(context).productImage);
                                StoreAppCubit.get(context).removeImage();
                              },
                              icon: Icon(Icons.highlight_remove),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    BlocConsumer<StoreAppCubit, StoreAppStates>(
                      listener: (context, state) {
                        if (state is CheckSocketState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'),
                                  Colors.amber, Duration(seconds: 5)));
                        }
                        if (state is InsertProductForUserSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              buildSnackBar(Text('تمت اضافة المنتج'),
                                  Colors.greenAccent, Duration(seconds: 3)));
                          StoreAppCubit.get(context).removeImage();
                          StoreAppCubit.get(context).getProductForUser(context,isRefresh: true);
                          //navigateToEnd(context, MainMerchantScreen());
                        } else if (state is InsertProductForUserErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              buildSnackBar(Text('لم تتم اضافة المنتج'),
                                  Colors.red, Duration(seconds: 3)));
                        }
                      },
                      builder: (context, state) {
                        return ConditionalBuilder(
                          condition: state != InsertProductForUserLoadingState,
                          fallback: (context) => CircularProgressIndicator(),
                          builder: (context) => defaultButton(
                              function: state
                                      is InsertProductForUserLoadingState
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        if (StoreAppCubit.get(context)
                                                .productImage !=
                                            null) {
                                          if (idCategory != null) {
                                            //  String convertBase64=base64Encode(StoreAppCubit.get(context).productImage!.readAsBytesSync());
                                            print(StoreAppCubit.get(
                                                context)
                                                .productImage!);
                                            StoreAppCubit.get(context)
                                                .insertProduct(
                                                    data: {
                                                  'name': productNameController
                                                      .text,
                                                  'shortDescription':
                                                      shortDescriptionController
                                                          .text,
                                                  'longDescription':
                                                      descriptionController
                                                          .text,
                                                  'price': priceController.text,
                                                  'quantity':
                                                      quantityController.text,
                                                  'token': token,
                                                  'idCategory': idSupOfCategory
                                                },
                                                    path: StoreAppCubit.get(
                                                            context)
                                                        .productImage!);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(buildSnackBar(
                                                    Text(
                                                        'يجب ان تختار قسم لهذا المنتج'),
                                                    Colors.red,
                                                    Duration(seconds: 2)));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(buildSnackBar(
                                                  Text(
                                                      'يجب ان تختار صورة للمنتج'),
                                                  Colors.red,
                                                  Duration(seconds: 2)));
                                        }
                                      }
                                    },
                              widget: Text(
                                'إضافة منتج',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                        );
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildColorPicker() => BlockPicker(
      pickerColor: Color.fromARGB(200, 255, 193, 7),
      availableColors: [
        Color(0xFF0B504F),
        Colors.red,
        Colors.black,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.purple,
        Colors.pink,
        Colors.grey,
        Colors.deepOrange,
        Colors.brown,
        Colors.cyanAccent,
        Colors.amber,
        Colors.indigoAccent,
        Colors.blueGrey,
        Colors.teal,
      ],
      onColorChanged: (color) {
        print(color
            .toString()
            .split(' Color(')
            .last
            .substring(0, color.toString().split(' Color(').last.length - 2));
        colors.add(color
            .toString()
            .split(' Color(')
            .last
            .substring(0, color.toString().split(' Color(').last.length - 2));
        hexColor = color.value;
      });
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/modules/categoryandfavorite/models/categories_model.dart';
import 'package:store/shared/components/components.dart';

class BuildCategories extends StatelessWidget {
  BuildCategories(
      {required this.context,
      required this.index,
      required this.data,
      Key? key})
      : super(key: key);
  BuildContext context;
  int index;
  Data data;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            height: 110.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(
              image: NetworkImage('${data.image}'),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          buildText(
              text: '${data.name}',
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontFamily: 'tajawal-light',
              ),
              lines: 1,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

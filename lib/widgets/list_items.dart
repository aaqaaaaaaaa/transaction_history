import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/constants.dart';

class ListItems extends StatelessWidget {
  const ListItems({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: AppColors.weekDayBackColor,
          alignment: Alignment.centerLeft,
          height: 50.h,
          padding: const EdgeInsets.all(15),
          child: Text(data['weekDay']),
        ),
        Flexible(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            itemCount: data["data"].length,
            itemBuilder: (context, index) {
              var map = data["data"][index];
              return Container(
                alignment: Alignment.center,
                height: 86.h,
                child: ListTile(
                  leading: Column(
                    children: [
                      map['isSale']
                          ? SvgPicture.asset('assets/lesion.svg')
                          : SvgPicture.asset('assets/profit.svg'),
                    ],
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 17.w),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(style: tStyleBlack20, children: [
                          TextSpan(text: map['title']),
                          WidgetSpan(child: SizedBox(width: 9.w)),
                          TextSpan(text: map['type']),
                        ]),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        map['date'],
                        style: tStyleBlack20.copyWith(fontSize: 10.sp),
                      ),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${map['isSale'] ? '-' : '+'} ${map['count']} ${map['type']}',
                        style: tStyleBlack20.copyWith(fontSize: 15.sp),
                      ),
                      Text(
                        '${map['isSale'] ? '-' : '+'} \$${map['price']} USD',
                        style: tStyleBlack20.copyWith(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

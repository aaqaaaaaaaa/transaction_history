import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transaction_history/widgets/list_items.dart';

import 'model/constants.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final items = ['Crypto', 'Crypto1', 'Crypto2', 'Crypto3'];
  final sellsItems = [
    'Crypto Sells',
    'Crypto Sells1',
    'Crypto Sells2',
    'Crypto Sells3'
  ];
  String? dropdownValue;
  String? sellsDropdownValue;
  List data = [];

  @override
  void initState() {
    super.initState();
    loadData();
    dropdownValue = items[0];
    sellsDropdownValue = sellsItems[0];
  }

  Future<String> loadData() async {
    var jsonData = await rootBundle.loadString('assets/data/data.json');
    setState(() {
      data = json.decode(jsonData);
    });
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(149.5.h),
          child: appBarBottom(context),
        ),
        backgroundColor: AppColors.primaryColor,
        titleSpacing: 0,
        title: Text('Transaction History', style: tStyle16),
        leading: SvgPicture.asset('assets/back_arrow.svg',
            color: AppColors.whiteColor, fit: BoxFit.none),
      ),
      body: ListView.builder(
        itemCount: data.length,
        primary: true,
        itemBuilder: (context, index) {
          return ListItems(data: data[index]);
        },
      ),
    );
  }

  Container appBarBottom(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            width: MediaQuery.of(context).size.width,
            height: 70.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.whiteColor.withOpacity(0.2))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                itemHeight: 69.h,
                iconDisabledColor: AppColors.whiteColor,
                iconEnabledColor: AppColors.whiteColor,
                dropdownColor: AppColors.primaryColor,
                isExpanded: true,
                iconSize: 30,
                value: dropdownValue,
                icon: SvgPicture.asset('assets/dropdownIcon.svg', width: 20),
                items: items.map((String items) {
                  return DropdownMenuItem<String>(
                    value: items,
                    child: Text(
                      items,
                      style: tStyle16.copyWith(fontSize: 35.sp),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => dropdownValue = value),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 14.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 11.r),
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    height: 49.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border:
                            Border.all(color: AppColors.whiteColor.withOpacity(0.2))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        itemHeight: 69.h,
                        dropdownColor: AppColors.primaryColor,
                        isExpanded: true,
                        iconSize: 30,
                        value: sellsDropdownValue,
                        icon: SvgPicture.asset('assets/dropdownIcon.svg'),
                        items: sellsItems.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items, style: tStyle16),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => sellsDropdownValue = value),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 49,
                  width: 49,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.whiteColor.withOpacity(0.2))),
                  child:
                      SvgPicture.asset('assets/calendar.svg', fit: BoxFit.none),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/core/constants/color.dart';
import 'package:leenas_mushrooms/core/constants/font_style.dart';
import 'package:leenas_mushrooms/core/constants/image_path_provider.dart';
import 'package:leenas_mushrooms/core/constants/size.dart';
import 'package:leenas_mushrooms/core/utils/common_util.dart';
import 'package:leenas_mushrooms/core/utils/responsive_utils.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

bool isWithGST = true;

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: AppColors.black),
        centerTitle: true,
        title: loadAssetPic(ImagePathProvider.logoletters, height: 40),
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      backgroundColor: AppColors.cardcolor,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundColor: AppColors.white,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20.h,
                    color: AppColors.black,
                  ),
                ),
              ),
              w10,
              Text(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  'Income & Expense Details',
                  style: AppFonts.getAppFont(
                      context: context,
                      color: AppColors.black,
                      weight: FontWeight.w500,
                      size: 21.sp)),
            ],
          ),
        ),
        isWithGST
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.white),
                    height: 55.h,
                    width: size.width * .8.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 53.h,
                          width: size.width * .4.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: AppColors.black),
                          child: Center(
                              child: Text('With GST',
                                  style: AppFonts.getAppFont(
                                    color: AppColors.white,
                                    context: context,
                                    size: 14,
                                    weight: FontWeight.w700,
                                  ))),
                        ),
                        Expanded(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isWithGST = false;
                                });
                              },
                              child: Text('Without GST',
                                  style: AppFonts.getAppFont(
                                    color: AppColors.black,
                                    context: context,
                                    size: 14,
                                    weight: FontWeight.w700,
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.white),
                    height: 55.h,
                    width: size.width * .8.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isWithGST = true;
                                });
                              },
                              child: Text('With GST',
                                  style: AppFonts.getAppFont(
                                    color: AppColors.black,
                                    context: context,
                                    size: 14,
                                    weight: FontWeight.w700,
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          height: 53.h,
                          width: size.width * .4.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: AppColors.black),
                          child: Center(
                              child: Text('Without GST',
                                  style: AppFonts.getAppFont(
                                    color: AppColors.white,
                                    context: context,
                                    size: 14,
                                    weight: FontWeight.w700,
                                  ))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
        h20,
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r)),
                ),
                width: size.width,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              width: size.width,
                              height: 180.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color:
                                      const Color.fromARGB(255, 162, 162, 162)),
                            ),
                          );
                        },
                      ),
                      h50
                    ])))),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/AppColors.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/Auth/Widget/Container.dart';
import 'package:lms/Module/Auth/Widget/authText.dart';
import 'package:lms/Module/Contest/ReadMoreInlineText.dart';

class Contestcard extends StatelessWidget {
  const Contestcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: OnBordingContainer(
        width: 180,
        height: 250,
        color: AppColors.white,
        widget: Padding(
          padding: EdgeInsets.only(right: 10.w, left: 10.h, top: 10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  Images.courses,
                  width: double.infinity,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthText(
                        text: 'Front end development',
                        size: 20,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      AuthText(
                        text: 'Description:',
                        size: 15,
                        color: AppColors.gray,
                        fontWeight: FontWeight.w700,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReadMoreInlineText(
                          text:
                              'pr  oduc t.desc  ript ion d nsk djn  csk  jdncs  kjd sjdnclkms efjsdij sdcma;sldmc;aefwoefslkdmcsldc,a;sc,dlfkeirghudfnvsldc,a;s',
                          trimLength: 19,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      AuthText(
                        text: 'Type : Programming',
                        size: 15,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Images.contest4,
                                height: 15,
                                width: 15,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 3),
                              AuthText(
                                text: '5/2/2024 2:00 AM',
                                size: 14,
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Row(
                            children: [
                              Image.asset(
                                Images.contest5,
                                height: 15,
                                width: 15,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 3),
                              AuthText(
                                text: '60 min',
                                size: 14,
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Images.contest6,
                                height: 15,
                                width: 15,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 3),
                              AuthText(
                                text: '152 participant',
                                size: 14,
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          AuthText(
                            text: 'Questions :20',
                            size: 14,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      OnBordingContainer(
                        width: 70,
                        height: 20,
                        color: AppColors.ok,
                        widget: AuthText(
                          text: 'Active',
                          size: 10,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            Images.contest7,
                            width: 100,
                            height: 100,
                          ),
                          Positioned(
                            top: 11,
                            right: 35,
                            child: AuthText(
                              text: 'Join',
                              size: 15,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

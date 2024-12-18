import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: CircleAvatar(
                  radius: 24.r,
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100.w,
                      height: 16.h,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 60.w,
                      height: 12.h,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 15.h,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                height: 200.h,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 5.w),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 30.w,
                  height: 12.h,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20.w),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 5.w),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 30.w,
                  height: 12.h,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Divider(
            height: 30.h,
            thickness: 0.5.h,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:msgmee/helper/context_ext.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/colors.dart';

class CustomShimmerEffect extends StatelessWidget {
  const CustomShimmerEffect({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.borderColor,
        highlightColor: AppColors.grey,
        child: child ??
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        SizedBox(width: 12),
                        Container(
                          height: 20,
                          width: context.screenWidth * .7,
                          decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
                  );
                }));
  }
}

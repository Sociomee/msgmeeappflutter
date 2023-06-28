import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';
import '../../../models/network_details_model.dart';

class NetworkUsageDetails extends StatelessWidget {
  const NetworkUsageDetails({super.key, required this.callsection});
  final bool callsection;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          callsection
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: callsData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            callsData[index].title,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            callsData[index].usage,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    );
                  })
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dataList[index].title,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            dataList[index].usage,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
        ],
      ),
    );
  }
}

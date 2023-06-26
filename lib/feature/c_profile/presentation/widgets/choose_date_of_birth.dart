import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';

class ChooseDateOfBirthBottomSheet extends StatelessWidget {
  const ChooseDateOfBirthBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 80,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: AppColors.lightgrey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 20),
            Text('Enter DOB',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: '10',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lightgrey)),
                            ),
                          ),
                          Text('date', style: TextStyle(color: AppColors.grey))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Jan',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightgrey))),
                          ),
                          Text('month', style: TextStyle(color: AppColors.grey))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: '2021',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightgrey))),
                          ),
                          Text('year', style: TextStyle(color: AppColors.grey))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

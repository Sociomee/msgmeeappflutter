import 'package:flutter/material.dart';
import '../../../../theme/custom_theme.dart';

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
            color: CustomTheme.white, borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 80,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: CustomTheme.lightgrey,
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
                                      BorderSide(color: CustomTheme.lightgrey)),
                            ),
                          ),
                          Text('date',
                              style: TextStyle(color: CustomTheme.grey))
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
                                        color: CustomTheme.lightgrey))),
                          ),
                          Text('month',
                              style: TextStyle(color: CustomTheme.grey))
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
                                        color: CustomTheme.lightgrey))),
                          ),
                          Text('year',
                              style: TextStyle(color: CustomTheme.grey))
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

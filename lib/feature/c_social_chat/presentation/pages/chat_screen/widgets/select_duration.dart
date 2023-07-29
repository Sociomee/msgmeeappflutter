import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../../../../../../theme/colors.dart';

class SelectDuration extends StatefulWidget {
  const SelectDuration({super.key});

  @override
  State<SelectDuration> createState() => _SelectDurationState();
}

class _SelectDurationState extends State<SelectDuration> {
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime(2023, 5, 6),
    DateTime(2023, 5, 21),
  ];
  List<int> selectedIndices = [];
  void onTapItem(int index) {
    if (selectedIndices.isEmpty) {
      // No items selected yet, so select the current item
      setState(() {
        selectedIndices.add(index);
      });
    } else if (selectedIndices.length == 1) {
      // One item already selected, so create a range selection
      int start = selectedIndices.first;
      int end = index;
      print('start $start');
      print('end $end');
      setState(() {
        selectedIndices.clear();
        selectedIndices
            .addAll(List.generate(end - start + 1, (i) => start + i));
      });
      print(selectedIndices);
    } else if (selectedIndices.length > 1) {
      int start = index;
      setState(() {
        selectedIndices.clear();
        selectedIndices.addAll(List.generate(1, (i) => start + i));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = CalendarDatePicker2Config(
      dayTextStyle: TextStyle(color: AppColors.black),
      selectedDayTextStyle: TextStyle(color: AppColors.white),
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: AppColors.primaryColor,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose Dates',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Reset',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF81C14B),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        CalendarDatePicker2(
          config: config,
          value: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _rangeDatePickerValueWithDefaultValue = dates),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 232, 232, 232),
                  offset: Offset(0, -10),
                  spreadRadius: 0,
                  blurRadius: 8,
                ),
              ],
              color: AppColors.white),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                    child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: 237,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor),
                  child: Text(
                    'Apply',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
              ),
            ],
          ),
        )
      ],
    );
  }
}

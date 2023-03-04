import 'package:flutter/material.dart';
import '../../../../theme/custom_theme.dart';

class DeleteCallBottomSheet extends StatelessWidget {
  const DeleteCallBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //   height: 4,
              //   width: 80,
              //   margin: EdgeInsets.only(top: 15),
              //   decoration: BoxDecoration(
              //       color: CustomTheme.grey,
              //       borderRadius: BorderRadius.circular(10)),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text('You are going to delete calls',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Container(
                  child: Text('Delete',
                      style: TextStyle(
                        fontSize: 16,
                      ))),
              Divider(color: CustomTheme.grey),
              Container(
                  child: Text('Cencel',
                      style: TextStyle(
                        fontSize: 16,
                      ))),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}

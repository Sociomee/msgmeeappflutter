import 'package:flutter/material.dart';

class CommonSuggestionWidget extends StatelessWidget {
  const CommonSuggestionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var image =
        'https://5.imimg.com/data5/IOS/Default/2022/3/GR/DP/JI/90098806/product-jpeg.png';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(image),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Used Cradle',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFFFC700),
                  ),
                  child: Text(
                    'Selling ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Hotels & restaurants',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'Posted on Mar 23, 2022',
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            )
          ],
        ),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Price: Rs 154',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF555555),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Icon(Icons.visibility, size: 15),
                SizedBox(width: 5),
                Text(
                  '552',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

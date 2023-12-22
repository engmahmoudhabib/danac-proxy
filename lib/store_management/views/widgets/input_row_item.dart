// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class inputRowItem extends StatelessWidget {
  String text;
  String total;
  inputRowItem({
    super.key,
    required this.text,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: ' : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: total,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
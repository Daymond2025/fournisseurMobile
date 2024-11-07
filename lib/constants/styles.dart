import 'package:daymond_dis/constants/constantApp.dart';
import 'package:flutter/material.dart';

import 'app_images.dart';

Widget emptyMessage(String text,
    {Color color = Colors.black, String? imagese}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            //color: const Color(0xFFFFEDD5),
          ),
          child: imagese != null
              ? Image.asset(
                  Images.vide,
                  height: 50,
                  width: 50,
                )
              : Icon(
                  Icons.sentiment_dissatisfied_outlined,
                  size: 32,
                ),
        ),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    ),
  );
}

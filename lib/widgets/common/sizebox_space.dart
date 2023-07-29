import 'package:flutter/material.dart';

Widget verticalSpace({double? height}){
  return  SizedBox(
    height: height ?? 0.0,
  );
}

Widget horizontalSpace({double? width}){
  return  SizedBox(
    width: width ?? 0.0,
  );
}
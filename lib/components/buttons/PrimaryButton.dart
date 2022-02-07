import 'package:flutter/material.dart';

Widget PrimaryButton({title="Primary", Function onPressed}) => ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
          elevation: 0,
          primary: Colors.green),
    );

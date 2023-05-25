




import 'package:flutter/material.dart';

class SnackShow{

  static showSuccess(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
            content: Text(msg, style: TextStyle(color: Colors.white),)
        ));
  }


  static showFailure(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.white,
            duration: Duration(seconds: 1),
            content: Text(msg)
        ));
  }

}
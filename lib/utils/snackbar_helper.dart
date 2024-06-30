import 'package:flutter/material.dart';

void showSuccessMessage(
  BuildContext context, {
  required String type,
  required String message,
}) {
  var snackBar;
  if (type == 'success') {
    snackBar = SnackBar(content: Text(message));
  } else {
    snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
  }

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

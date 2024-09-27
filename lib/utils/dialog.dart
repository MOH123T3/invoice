import 'package:flutter/material.dart';

class ShowDialog {
  static dialog(context, title, content) {
    return showDialog(
      context: context,
      // useSafeArea: true,
      barrierDismissible: true,

      builder: (context) {
        return AlertDialog(
          actions: [content],
          titlePadding: EdgeInsets.zero,
          contentTextStyle: TextStyle(fontSize: 12, color: Colors.black),
          titleTextStyle: TextStyle(fontSize: 15, color: Colors.white),
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(8),
          title: title,
          // content: content,
        );
      },
    );
  }
}

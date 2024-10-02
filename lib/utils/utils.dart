import 'package:fluttertoast/fluttertoast.dart';
import 'package:autorepair/imports.dart';

class Utils {
  static showToast(msg, backgroundColor) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColor,
        textColor: Colors.white);
  }

  static noData() {
    return Center(
      child: Image.asset(
        'assets/file.png',
        height: 50,
      ),
    );
  }
}

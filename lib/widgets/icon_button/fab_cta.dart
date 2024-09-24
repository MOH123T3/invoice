import 'package:autorepair/imports.dart';

class FabCTA extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function()? onTap;
  const FabCTA({Key? key, this.title, this.onTap, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          TextBuilder(text: title),
        ],
      ),
    );
  }
}

class ButtonIcon extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const ButtonIcon({Key? key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 70),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.black),
          child: TextBuilder(
            text: title,
            textOverflow: TextOverflow.clip,
            fontSize: 12.0,
            color: Colors.white,
          )),
    );
  }
}

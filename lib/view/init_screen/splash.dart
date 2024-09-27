import 'package:autorepair/data/admin_database.dart';
import 'package:autorepair/imports.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> {
  final db = AdminProfileDatabase();

  @override
  void initState() {
    super.initState();

    navigate();
  }

  navigate() async {
    var alreadyLogin = await db.fetchProfileAll();

    print('alreadyLogin.isEmpty  - ${alreadyLogin.isEmpty}');
    if (alreadyLogin.isEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const RegisterPage()),
            (route) => false);
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainView(initRoute: 0)),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
          child: Image.asset(
        'assets/mechanic.png',
        height: 200,
      )),
    );
  }
}

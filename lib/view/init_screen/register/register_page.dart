import 'package:autorepair/data/admin_database.dart';
import 'package:autorepair/imports.dart';
import 'package:autorepair/utils/utils.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final db = AdminProfileDatabase();

  TextEditingController yourNameTextEditingController = TextEditingController();

  TextEditingController businessTextEditingController = TextEditingController();

  TextEditingController businessNameTextEditingController =
      TextEditingController();

  TextEditingController mobileNumberTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: 100.0),
            Image.asset(
              'assets/mechanic.png',
              height: 75,
            ),
            const SizedBox(height: 50.0),
            CustomTextField(
              controller: yourNameTextEditingController,
              label: 'Your Name',
              prefixIcon: const Icon(
                Icons.person,
                size: 25,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              textInputType: TextInputType.number,
              controller: mobileNumberTextEditingController,
              label: 'Mobile Number',
              prefixIcon: const Icon(
                Icons.phone,
                size: 25,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              controller: businessNameTextEditingController,
              label: 'Business Name',
              prefixIcon: const Icon(
                Icons.shop_2,
                size: 25,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              controller: businessTextEditingController,
              label: 'Business Address',
              prefixIcon: const Icon(
                Icons.pin_drop_rounded,
                size: 25,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 50.0),
            ButtonIcon(
              onTap: () {
                if (mobileNumberTextEditingController.text.isEmpty ||
                    mobileNumberTextEditingController.text.length < 10) {
                  Utils.showToast('Mobile Number Required', Colors.red);
                } else {
                  save(context);
                }
              },
              title: "Login",
            ),
          ],
        ),
      ),
    );
  }

  void save(context) async {
    try {
      var profile = AdminDatabase(
        adminName: yourNameTextEditingController.text,
        businessAddress: businessTextEditingController.text,
        businessName: businessNameTextEditingController.text,
        mobileNumber:
            int.parse(mobileNumberTextEditingController.text.toString()),
      );

      await db.addData(profile);
      Navigator.pop(context);
      Get.to(const MainView(
        initRoute: 0,
      ));
    } catch (e) {
      e.toString();
    }
  }
}

import 'package:get/get.dart';
import 'package:autorepair/data/customer_profile_database.dart';
import 'package:autorepair/imports.dart';
import 'package:autorepair/view/billing/filter_products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autorepair/utils/utils.dart';

class CreateInvoiceTemplate extends StatefulWidget {
  const CreateInvoiceTemplate({super.key});

  @override
  State<CreateInvoiceTemplate> createState() => _CreateInvoiceTemplateState();
}

class _CreateInvoiceTemplateState extends State<CreateInvoiceTemplate> {
  final db = CustomerProfileDatabaseDatabase();

  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  TextEditingController customerNameTextEditingController =
      TextEditingController();

  TextEditingController bikeModelTextEditingController =
      TextEditingController();

  TextEditingController registerNumberTextEditingController =
      TextEditingController();

  TextEditingController mobileNumberTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const TextBuilder(
          text: 'Customer Details',
          color: Colors.black,
        ),
        // actions: const [
        //   Center(
        //     child: Padding(
        //       padding: EdgeInsets.only(right: 15),
        //       child: TextBuilder(
        //         text: '001',
        //         fontSize: 15.0,
        //         color: Colors.black38,
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: 20.0),
            Image.asset(
              'assets/user.png',
              height: 100,
            ),
            const SizedBox(height: 20.0),
            CustomTextField(
              controller: customerNameTextEditingController,
              label: 'Customer Name',
              prefixIcon: const Icon(
                Icons.person,
                size: 25,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              controller: bikeModelTextEditingController,
              label: 'Bike Model',
              prefixIcon: const Icon(
                Icons.bike_scooter,
                size: 25,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15.0),
            CustomTextField(
              controller: registerNumberTextEditingController,
              label: 'Register Number',
              prefixIcon: const Icon(
                Icons.app_registration_outlined,
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
            const SizedBox(height: 20.0),
            ButtonIcon(
              onTap: () {
                if (registerNumberTextEditingController.text.isEmpty ||
                    registerNumberTextEditingController.text.length < 10) {
                  Utils.showToast('Register Number Required', Colors.red);
                } else {
                  save(context);
                }
              },
              title: "NEXT",
            ),
          ],
        ),
      ),
    );
  }

  void save(context) async {
    try {
      String? oldRegisterNumber = await asyncPrefs.getString('registerNumber');

      if (oldRegisterNumber == registerNumberTextEditingController.text) {
        Navigator.pop(context);
        Get.to(const FilterProductsScreen());
      } else {
        var profile = CustomerProfileDatabase(
            customerName: customerNameTextEditingController.text,
            bikeModel: bikeModelTextEditingController.text,
            date: DateTime.now().toString(),
            mobileNumber:
                int.parse(mobileNumberTextEditingController.text.toString()),
            registerNumber:
                registerNumberTextEditingController.text.toString());

        await db.addData(profile);

        asyncPrefs.setString(
            'registerNumber', registerNumberTextEditingController.text);

        // asyncPrefs.setBool('isLogin', true);

        Navigator.pop(context);
        Get.to(const FilterProductsScreen());
      }
    } catch (e) {
      e.toString();
    }
  }
}

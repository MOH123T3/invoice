// ignore_for_file: use_build_context_synchronously

import 'package:autorepair/imports.dart';
import 'package:autorepair/view/add_products/spare_part_list.dart';
import 'package:autorepair/data/product_database.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final db = SparePartDatabase();

  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController bikeModelNo = TextEditingController();
  final _formPageKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    // Todo temporary
    var part2 = SparePart(
        bikeModelNo: "All", partName: "Oil", partPrice: 410, partQuantity: 30);
    await db.addProduct(part2);

    var part3 = SparePart(
        bikeModelNo: "All",
        partName: "Tyre",
        partPrice: 1200,
        partQuantity: 20);
    await db.addProduct(part3);
    var part4 = SparePart(
        bikeModelNo: "All",
        partName: "Brake liner",
        partPrice: 200,
        partQuantity: 150);
    await db.addProduct(part4);
    var part5 = SparePart(
        bikeModelNo: "All",
        partName: "Indicators",
        partPrice: 150,
        partQuantity: 50);
    await db.addProduct(part5);
    var part6 = SparePart(
        bikeModelNo: "All",
        partName: "Sit Cover",
        partPrice: 350,
        partQuantity: 60);
    await db.addProduct(part6);
    var part7 = SparePart(
        bikeModelNo: "All",
        partName: "Side Mirror",
        partPrice: 600,
        partQuantity: 30);
    await db.addProduct(part7);
    var part8 = SparePart(
        bikeModelNo: "All",
        partName: "Full Engine Work",
        partPrice: 7000,
        partQuantity: 0);
    await db.addProduct(part8);
    var part9 = SparePart(
        bikeModelNo: "All",
        partName: "Half Engine Work",
        partPrice: 3500,
        partQuantity: 0);
    await db.addProduct(part9);
    var part10 = SparePart(
        bikeModelNo: "All",
        partName: "Service",
        partPrice: 500,
        partQuantity: 0);
    await db.addProduct(part10);
    var part11 = SparePart(
        bikeModelNo: "All",
        partName: "Washing",
        partPrice: 100,
        partQuantity: 0);
    await db.addProduct(part11);
    var part12 = SparePart(
        bikeModelNo: "All",
        partName: "Re-Paint",
        partPrice: 3000,
        partQuantity: 0);
    await db.addProduct(part12);
    var part13 = SparePart(
        bikeModelNo: "All",
        partName: "Wheel balancing",
        partPrice: 300,
        partQuantity: 0);
    await db.addProduct(part13);
    var part14 = SparePart(
        bikeModelNo: "All",
        partName: "battery",
        partPrice: 1500,
        partQuantity: 0);
    await db.addProduct(part14);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const TextBuilder(
          text: "Add Products",
          textOverflow: TextOverflow.clip,
          fontSize: 15.0,
          color: Colors.black,
        ),
      ),
      body: Form(
        key: _formPageKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getTextField(productName, "Product Name", Icons.person,
                            "Please insert product name"),
                        getTextField(productPrice, "Product Price",
                            Icons.attach_money, "Please insert product price"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getTextField(
                            productQuantity,
                            "Product Quantity",
                            Icons.production_quantity_limits,
                            "Please insert product quantity"),
                        getTextField(
                            bikeModelNo,
                            'Bike Model No.',
                            Icons.numbers_rounded,
                            "Please insert product bike model number"),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonIcon(
                      title: "Save",
                      onTap: () async {
                        if (_formPageKey.currentState!.validate()) {
                          save();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SparePartList()
          ],
        ),
      ),
    );
  }

  void save() async {
    var part = SparePart(
        bikeModelNo: bikeModelNo.text,
        partName: productName.text,
        partPrice: int.parse(productPrice.text),
        partQuantity: int.parse(productQuantity.text));
    await db.addProduct(part);

    bikeModelNo.clear();
    productName.clear();
    productPrice.clear();
    productQuantity.clear();

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }

  getTextField(controller, name, prefixIcon, valueValidator) {
    return SizedBox(
      height: 37,
      width: 150,
      child: CustomTextField(
        validator: (value) => (value!.isEmpty) ? valueValidator : null,
        controller: controller,
        label: name,
        prefixIcon: Icon(
          prefixIcon,
          size: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}

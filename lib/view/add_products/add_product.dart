import 'package:flutter/material.dart';
import 'package:autorepair/data/product_database.dart';
import 'package:autorepair/view/add_products/part_list.dart';
import 'package:autorepair/widgets/text/text_builder.dart';
import 'package:autorepair/widgets/text_filed/custom_text_filed.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Row(
                children: [
                  getTextField(productName, "Product Name", Icons.person,
                      "Please insert product name"),
                  const SizedBox(
                    width: 20,
                  ),
                  getTextField(productPrice, "Product Price",
                      Icons.attach_money, "Please insert product price"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  getTextField(
                      productQuantity,
                      "Product Quantity",
                      Icons.production_quantity_limits,
                      "Please insert product quantity"),
                  const SizedBox(
                    width: 20,
                  ),
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
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black)),
                  onPressed: () async {
                    if (_formPageKey.currentState!.validate()) {
                      save();
                    }
                  },
                  child: const TextBuilder(
                    text: "Save",
                    textOverflow: TextOverflow.clip,
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SparePartList()
            ],
          ),
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
      height: 35,
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

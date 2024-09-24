// ignore_for_file: must_be_immutable

import 'package:autorepair/controller/part_controller.dart';
import 'package:autorepair/data/product_database.dart';
import 'package:autorepair/imports.dart';

class ProductInvoiceScreen extends StatefulWidget {
  List<SparePart>? dataList;

  ProductInvoiceScreen({super.key, this.dataList});

  @override
  State<ProductInvoiceScreen> createState() => _ProductInvoiceScreenState();
}

class _ProductInvoiceScreenState extends State<ProductInvoiceScreen> {
  final part = PartController();
  var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  List<String> selectedItemValue = <String>[];
  List<SparePart> dataList = [];
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    dataList.clear();
    dataList = widget.dataList!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const TextBuilder(
            text: 'Products',
            fontSize: 15,
            color: Colors.black,
          )),
      body: Column(
        children: <Widget>[
          if (widget.dataList == null || widget.dataList!.isEmpty)
            const Expanded(
              child: Center(
                  child: TextBuilder(
                fontSize: 15,
                text: 'No item selected',
                color: Colors.black,
              )),
            )
          else
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 223, 223, 223),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        for (int i = 0; i < dataList.length; i++) {
                          selectedItemValue.add("1");
                        }
                        int price = 0;

                        price = dataList[index].partPrice! *
                            int.parse(selectedItemValue[index]);

                        print('price- $price');

                        return Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ListTile(
                                  title: TextBuilder(
                                    text: dataList[index].partName.toString(),
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                  subtitle: TextBuilder(
                                    text: '₹ $price',
                                    fontSize: 10,
                                  ),
                                  leading: const Icon(
                                    Icons.settings,
                                    size: 20,
                                  )),
                            ),
                            Expanded(
                                flex: 1,
                                child: DropdownButton<String>(
                                  alignment: AlignmentDirectional.center,
                                  iconSize: 15,
                                  value: selectedItemValue[index].toString(),
                                  items: items.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: TextBuilder(
                                        fontSize: 15,
                                        text: value,
                                      ),
                                    );
                                  }).toList(),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedItemValue[index] = value!;
                                    });
                                  },
                                ))
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  total(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  total() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextBuilder(
          text: "Total Price",
        ),
        TextBuilder(text: "$totalPrice")
      ],
    );
  }
}

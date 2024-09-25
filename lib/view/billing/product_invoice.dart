// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:autorepair/controller/part_controller.dart';
import 'package:autorepair/data/customer_profile_database.dart';
import 'package:autorepair/data/product_database.dart';
import 'package:autorepair/imports.dart';
import 'package:autorepair/view/billing/billing.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductInvoiceScreen extends StatefulWidget {
  List<SparePart>? dataList;

  ProductInvoiceScreen({super.key, this.dataList});

  @override
  State<ProductInvoiceScreen> createState() => _ProductInvoiceScreenState();
}

class _ProductInvoiceScreenState extends State<ProductInvoiceScreen> {
  final part = PartController();
  var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  var customerProfileDatabase = CustomerProfileDatabaseDatabase();
  TextEditingController labourCharge = TextEditingController();

  List<String> selectedItemValue = <String>[];
  List<SparePart> dataList = [];
  int totalPrice = 0;

  String registerName = "-";
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    dataList.clear();
    dataList = widget.dataList!;
    info();
  }

  info() async {
    var info = await customerProfileDatabase.fetchProfileAll();
    setState(() {
      for (var i = 0; i < info.length; i++) {
        registerName = info[i].registerNumber.toString();
        date = DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(info[i].date.toString())) as DateTime;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const TextBuilder(
            text: '',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextBuilder(
                              text: "Register Number :",
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            TextBuilder(
                              text: registerName,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            TextBuilder(
                              text: "Date :",
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            TextBuilder(
                                text:
                                    "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}",
                                fontSize: 11.0,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 223, 223, 223),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: dataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          for (int i = 0; i < dataList.length; i++) {
                            selectedItemValue.add("1");
                          }
                          int price = 0;

                          price = dataList[index].partPrice! *
                              int.parse(selectedItemValue[index]);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: TextBuilder(
                                    text: dataList[index].partName.toString(),
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                  subtitle: TextBuilder(
                                    text: '₹ $price',
                                    fontSize: 10,
                                  ),
                                  leading: Image.asset(
                                    'assets/spare_part.png',
                                    height: 25,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      width: 50,
                                      height: 30,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          alignment:
                                              AlignmentDirectional.center,
                                          iconSize: 15,
                                          value: selectedItemValue[index]
                                              .toString(),
                                          items: items.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: TextBuilder(
                                                fontSize: 12,
                                                text: value,
                                              ),
                                            );
                                          }).toList(),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedItemValue[index] = value!;
                                            });
                                          },
                                        ),
                                      ))),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextBuilder(
                        color: Colors.black,
                        text: "Labour Charges",
                      ),
                      SizedBox(
                          height: 30,
                          width: 100,
                          child: CustomTextField(
                            controller: labourCharge,
                            textInputType: TextInputType.number,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonIcon(
                    onTap: () {
                      Get.to(BillingScreen());
                    },
                    title: "NEXT",
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

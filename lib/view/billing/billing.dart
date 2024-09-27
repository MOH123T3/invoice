// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:autorepair/data/billing_database.dart';
import 'package:autorepair/data/customer_profile_database.dart';
import 'package:autorepair/data/product_database.dart';
import 'package:autorepair/data/selected_billing_product_database.dart';
import 'package:autorepair/utils/app_colors.dart';
import 'package:autorepair/utils/dialog.dart';
import 'package:autorepair/widgets/text/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillingScreen extends StatefulWidget {
  int? total;
  String? labourCharges;
  List<SparePart>? totalDataList;
  BillingScreen(
      {super.key, this.total, this.labourCharges, this.totalDataList});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  var customerProfileDatabase = CustomerProDatabase();
  var detailBillingDatabase = DetailBillingDatabase();
  var selectedBillingProductDatabase = BillingProductDatabaseDatabase();

  String? date;
  String registerName = "-";
  String yourName = "-";
  String yourMobileNumber = "-";
  String id = "-";
  String model = "-";
  List<SparePart> totalDataList = <SparePart>[];
  int grandTotal = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    info();
  }

  info() async {
    totalDataList.clear();
    var info = await customerProfileDatabase.fetchProfileAll();
    setState(() {
      for (var i = 0; i < info.length; i++) {
        date = DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(info[i].date.toString()));
        registerName = info[i].registerNumber.toString();
        yourMobileNumber = info[i].mobileNumber.toString();
        yourName = info[i].customerName.toString();
        id = info[i].id.toString();
        model = info[i].bikeModel.toString();
      }

      totalDataList = widget.totalDataList!;

      grandTotal = widget.total! + int.parse(widget.labourCharges!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const TextBuilder(
            text: 'Billing',
            fontSize: 15,
            color: Colors.black,
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                leadingText("Invoice Id :", id),
                const SizedBox(
                  height: 5,
                ),
                leadingText("Name :", yourName),
                const SizedBox(
                  height: 5,
                ),
                leadingText("Mobile Number :", yourMobileNumber),
                const SizedBox(
                  height: 5,
                ),
                leadingText("Date :", date ?? ""),
                const SizedBox(
                  height: 5,
                ),
                leadingText("Bike Model :", model),
                const SizedBox(
                  height: 5,
                ),
                leadingText("Register Number :", registerName),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            // padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 223, 223),
            ),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: headingTextData('Id'),
                    ),
                    Expanded(
                      flex: 3,
                      child: headingTextData('Product Name'),
                    ),
                    Expanded(
                      flex: 2,
                      child: headingTextData("Price"),
                    ),
                    Expanded(
                      flex: 2,
                      child: headingTextData('Quantity'),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: totalDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextBuilder(
                                textAlign: TextAlign.center,
                                fontSize: 10,
                                text: '${index + 1}',
                              )),
                          Expanded(
                              flex: 3,
                              child: TextBuilder(
                                textAlign: TextAlign.center,
                                fontSize: 10,
                                text: "${totalDataList[index].partName}",
                              )),
                          Expanded(
                              flex: 2,
                              child: TextBuilder(
                                textAlign: TextAlign.center,
                                fontSize: 10,
                                text: '${totalDataList[index].partPrice}',
                              )),
                          Expanded(
                              flex: 2,
                              child: TextBuilder(
                                textAlign: TextAlign.center,
                                fontSize: 10,
                                text: '${totalDataList[index].partQuantity}',
                              )),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 223, 223),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextBuilder(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      text:
                          "Labour Charges :   ${widget.labourCharges ?? "0"} ",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextBuilder(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      text: "Grand Total    :    $grandTotal",
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  ShowDialog.dialog(
                      context,
                      Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: AppColors.dashColor[3],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Column(
                          children: [
                            TextBuilder(
                              text: 'Payment here',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Icon(
                              Icons.qr_code_2_outlined,
                              size: 100,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextBuilder(
                                  fontSize: 12,
                                  text: "Payable Amount",
                                ),
                                TextBuilder(text: grandTotal.toString()),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextBuilder(
                                  fontSize: 12,
                                  text: "Due Amount",
                                ),
                                TextBuilder(text: grandTotal.toString()),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextBuilder(
                                  fontSize: 12,
                                  text: "Payment Type",
                                ),
                                TextBuilder(text: grandTotal.toString()),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 35,
                                width: 130,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.dashColor[3]),
                                child: TextBuilder(
                                  text: "Done",
                                  textOverflow: TextOverflow.clip,
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                },
                child: Container(
                    height: 35,
                    width: 130,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.dashColor[3]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/money.png',
                          height: 25,
                        ),
                        const TextBuilder(
                          text: "Pay Amount",
                          textOverflow: TextOverflow.clip,
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                    height: 35,
                    width: 130,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.dashColor[1]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.picture_as_pdf,
                          size: 25,
                          color: Colors.yellow,
                        ),
                        const TextBuilder(
                          text: "Pdf Dow.",
                          textOverflow: TextOverflow.clip,
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ],
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  headingTextData(text) {
    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      height: 30,
      color: Colors.black,
      child: TextBuilder(
        text: text,
        textOverflow: TextOverflow.clip,
        fontSize: 11,
        color: Colors.white,
      ),
    );
  }

  leadingText(title, value) {
    return Row(
      children: [
        TextBuilder(
          text: title,
          fontSize: 12.0,
          color: Colors.black,
        ),
        const SizedBox(
          width: 13,
        ),
        TextBuilder(
          text: value,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
          color: Colors.blueGrey,
        ),
      ],
    );
  }

  setAmount() async {
    var addDetails = BillingDatabase(
      customerName: yourName,
      date: date,
      id: int.parse(id),
      labourCharges: widget.labourCharges,
      registerNumber: registerName,
    );

    await detailBillingDatabase.addData(addDetails);
  }
}

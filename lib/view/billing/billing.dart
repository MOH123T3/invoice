// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:autorepair/data/customer_profile_database.dart';
import 'package:autorepair/utils/app_colors.dart';
import 'package:autorepair/widgets/text/text_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/icon_button/fab_cta.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  var customerProfileDatabase = CustomerProfileDatabaseDatabase();
  DateTime date = DateTime.now();
  String registerName = "-";
  String yourName = "-";
  String yourMobileNumber = "-";
  String id = "-";
  String model = "-";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    info();
  }

  info() async {
    var info = await customerProfileDatabase.fetchProfileAll();
    setState(() {
      for (var i = 0; i < info.length; i++) {
        date = DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(info[i].date.toString())) as DateTime;
        registerName = info[i].registerNumber.toString();
        yourMobileNumber = info[i].mobileNumber.toString();
        yourName = info[i].customerName.toString();
        id = info[i].id.toString();
        model = info[i].bikeModel.toString();
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
            text: 'Billing',
            fontSize: 15,
            color: Colors.black,
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                leadingText("Date :",
                    "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}"),
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
                _header(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 2,
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
                                text: 'Oil',
                              )),
                          Expanded(
                              flex: 2,
                              child: TextBuilder(
                                textAlign: TextAlign.center,
                                fontSize: 10,
                                text: '400 Rs',
                              )),
                          Expanded(
                              flex: 2,
                              child: TextBuilder(
                                textAlign: TextAlign.center,
                                fontSize: 10,
                                text: '1',
                              )),
                          Expanded(
                              flex: 2,
                              child: TextBuilder(
                                textAlign: TextAlign.center,
                                fontSize: 10,
                                text: '400',
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextBuilder(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      text: "Labour Charges : ",
                    ),
                    TextBuilder(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      text: "Grand Total : ",
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
                onTap: () {},
                child: Container(
                    height: 30,
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
                    height: 30,
                    width: 130,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.dashColor[5]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/qr_code.png',
                          height: 25,
                          color: Colors.yellow,
                        ),
                        const TextBuilder(
                          text: "Qr Code",
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

  _header() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
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
        Expanded(
          flex: 2,
          child: headingTextData('Total'),
        ),
      ],
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
}

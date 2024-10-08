// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:autorepair/data/customer_profile_database.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:autorepair/data/product_database.dart';
import 'package:autorepair/view/billing/product_invoice.dart';
import 'package:autorepair/widgets/text/text_builder.dart';

class FilterProductsScreen extends StatefulWidget {
  CustomerProfile? customerProfileData;

  FilterProductsScreen({Key? key, this.customerProfileData}) : super(key: key);

  @override
  _FilterProductsScreenState createState() => _FilterProductsScreenState();
}

class _FilterProductsScreenState extends State<FilterProductsScreen> {
  List<SparePart>? selectedUserList = [];
  List<SparePart> userList = [];
  final db = SparePartDatabase();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var partList = await db.fetchAll();
    setState(() {
      for (int i = 0; i < partList.length; i++) {
        userList.add(SparePart(
            id: i,
            bikeModelNo: partList[i].bikeModelNo,
            partName: partList[i].partName,
            partPrice: partList[i].partPrice,
            partQuantity: partList[i].partQuantity));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextBuilder(
          text: "Choose Products",
          textOverflow: TextOverflow.clip,
          fontSize: 15.0,
          color: Colors.black,
        ),
      ),
      body: FilterListWidget<SparePart>(
        themeData: FilterListThemeData(context,
            wrapAlignment: WrapAlignment.center,
            headerTheme: HeaderThemeData(
                headerTextStyle: TextStyle(fontSize: 12),
                backgroundColor: Colors.white,
                searchFieldHintTextStyle: TextStyle(fontSize: 12),
                searchFieldTextStyle: TextStyle(fontSize: 12),
                searchFieldBorderRadius: 8),
            choiceChipTheme: ChoiceChipThemeData(
                selectedBackgroundColor: Colors.greenAccent,
                backgroundColor: const Color.fromARGB(255, 202, 200, 200),
                selectedTextStyle:
                    GoogleFonts.poppins(color: Colors.black, fontSize: 10),
                textStyle:
                    GoogleFonts.poppins(color: Colors.black, fontSize: 10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5)),
            controlButtonBarTheme: ControlButtonBarThemeData(context,
                height: 30,
                backgroundColor: Colors.black,
                controlButtonTheme: ControlButtonThemeData(
                    textStyle: TextStyle(color: Colors.white)))),
        hideSelectedTextCount: true,
        listData: userList,
        selectedListData: selectedUserList,
        onApplyButtonClick: (list) {
          Get.to(ProductInvoiceScreen(
            dataList: list,
            customerProfileData: widget.customerProfileData,
          ));
        },
        choiceChipLabel: (item) {
          return item!.partName;
        },
        validateSelectedItem: (list, val) {
          return list!.contains(val);
        },
        onItemSearch: (user, query) {
          return user.partName!.toLowerCase().contains(query.toLowerCase());
        },
        onCloseWidgetPress: () {},
      ),
    );
  }
}

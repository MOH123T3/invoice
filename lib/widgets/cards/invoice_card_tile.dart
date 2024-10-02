// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:autorepair/data/billing_database.dart';
import 'package:autorepair/imports.dart';

class InvoiceCardTile extends StatelessWidget {
  final BillingDatabase data;
  const InvoiceCardTile({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          useSafeArea: true,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
                actionsOverflowAlignment: OverflowBarAlignment.center,
                backgroundColor: const Color.fromARGB(255, 234, 234, 234),
                actionsAlignment: MainAxisAlignment.start,
                alignment: Alignment.center,
                actionsPadding: EdgeInsets.all(10),
                buttonPadding: EdgeInsets.zero,
                contentPadding: const EdgeInsets.all(8),
                actions: [
                  Image.asset(
                    'assets/bill.png',
                    height: 40,
                    width: 50,
                  ),
                  TextBuilder(text: data.customerName),
                  Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            info('Mobile Number', data.mobileNumber),
                            info('Register Number', data.registerNumber),
                            info('Payment Type', data.paymentType),
                            info('Paid Amount', data.paidAmount),
                            info('Due Amount', data.dueAmount),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  )
                ]);
          },
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: data.dueAmount == "0"
              ? Colors.greenAccent
              : AppColors.dashColor[4],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/bill.png',
                      height: 40,
                      width: 50,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBuilder(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          text: data.customerName,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextBuilder(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          text: data.registerNumber,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        data.dueAmount == "0"
                            ? Container(
                                height: 20,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.green,
                                ),
                                child: TextBuilder(
                                  text: "All Clear",
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            : Container(
                                height: 20,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.red,
                                ),
                                child: TextBuilder(
                                  text: "Due Amount: Rs.${data.dueAmount}",
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBuilder(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      text: "Rs. ${data.totalAmount}",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 12,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: AppColors.dashColor[1]),
                      child: TextBuilder(
                        text: data.paymentType,
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextBuilder(
                      fontWeight: FontWeight.w400,
                      fontSize: 9,
                      text: "${data.date}",
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  info(String s, String? customerName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextBuilder(
          text: s,
          fontSize: 11,
          color: Colors.redAccent,
        ),
        SizedBox(
          width: 10,
        ),
        TextBuilder(
          text: customerName,
          fontSize: 10,
        ),
      ],
    );
  }
}

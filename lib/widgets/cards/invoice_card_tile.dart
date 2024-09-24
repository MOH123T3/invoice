// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:autorepair/imports.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InvoiceCardTile extends StatelessWidget {
  final InvoiceModel data;
  const InvoiceCardTile({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBuilder(
                text: data.userName,
                fontSize: 12,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    useSafeArea: true,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        actionsPadding: EdgeInsets.zero,
                        buttonPadding: EdgeInsets.zero,
                        contentPadding: const EdgeInsets.all(8),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextBuilder(text: 'Invoice'),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        content: InteractiveViewer(
                          minScale: 0.1,
                          maxScale: 1.9,
                          child: Image.asset(
                            data.invoiceURL!,
                            height: size.height * 0.5,
                            width: size.width,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: 20.0,
                  width: 25.0,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.picture_as_pdf,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextBuilder(
                text: "Date",
                fontSize: 10,
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 10,
              ),
              TextBuilder(
                text: "23-09-2023",
                fontSize: 10,
                color: Colors.black,
              ),
            ],
          ),
          Divider(),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 22,
                  width: 60,
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsets.all(05),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.red),
                  child: TextBuilder(
                    text: "Due",
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                            trailing: TextBuilder(
                              text: "Rs 5500",
                              color: Colors.black,
                              fontSize: 8,
                            ),
                            leading: FaIcon(FontAwesomeIcons.moneyCheck),
                            iconColor: Colors.blueAccent,
                            title: TextBuilder(
                              text: "Total Amount",
                              color: Colors.black,
                              fontSize: 8,
                            )),
                        ListTile(
                            trailing: TextBuilder(
                              text: "Rs 2500",
                              color: Colors.black,
                              fontSize: 8,
                            ),
                            leading: FaIcon(FontAwesomeIcons.moneyBillWheat),
                            iconColor: Colors.red,
                            title: TextBuilder(
                              text: "Paid Amount",
                              color: Colors.black,
                              fontSize: 8,
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

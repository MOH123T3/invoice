import 'package:autorepair/imports.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final invoice = InvoiceController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 206, 204, 204),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          shrinkWrap: true,
          itemCount: invoice.invoice.length,
          itemBuilder: (BuildContext context, int i) {
            return InvoiceCardTile(
              data: invoice.invoice[i],
            );
          },
        ),
      ),
    );
  }
}

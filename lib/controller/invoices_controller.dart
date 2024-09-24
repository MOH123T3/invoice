import 'package:get/get.dart';

import '../view/invoice_admin/transaction/transaction.dart';

class AllInvoiceController extends GetxController {
  final RxList _invoicesList = [].obs;

  get invoicesList => _invoicesList;
  // get invoicesList => _invoicesList;
  // get all invoices
  // creeate new invoice
  void createNewInvoice(Transaction invoice) => _invoicesList.add(invoice);
  // download inovice
  // delete invoice
}

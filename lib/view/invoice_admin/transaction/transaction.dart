import 'package:autorepair/data/billing_database.dart';
import 'package:autorepair/imports.dart';
import 'package:autorepair/utils/utils.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  var finalBillingDatabase = FinalBillingDatabase();
  List<BillingDatabase> billingListData = <BillingDatabase>[];

  @override
  void initState() {
    super.initState();
  }

  getData() async {
    var data = await finalBillingDatabase.fetchAll();
    billingListData = data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainView(
                        initRoute: 0,
                      )));
          return false;
        },
        child: Scaffold(
          body: FutureBuilder(
              future: getData(),
              builder: (context, snapShots) {
                if (snapShots.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (billingListData.isNotEmpty) {
                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    shrinkWrap: true,
                    itemCount: billingListData.length,
                    itemBuilder: (BuildContext context, int i) {
                      return InvoiceCardTile(
                        data: billingListData[i],
                      );
                    },
                  );
                } else {
                  return Utils.noData();
                }
              }),
        ),
      ),
    );
  }
}

import 'package:autorepair/data/billing_database.dart';
import 'package:autorepair/data/product_database.dart';
import 'package:autorepair/imports.dart';
import 'package:autorepair/view/home/chart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final pay = PaymentController();
  var items = [
    "This week",
    "Last week",
    "This month",
    "Last month",
    "This year",
    "Last year",
    "Total"
  ];
  String dropdownValue = "This month";

  final dash = DashboardController();

  var finalBillingDatabase = FinalBillingDatabase();
  final productListDatabase = SparePartDatabase();

  List<BillingDatabase> billingListData = <BillingDatabase>[];

  int totalProducts = 0;

  int totalCustomers = 0;

  int totalRevenue = 0;

  int totalPaid = 0;

  int totalDue = 0;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    List<int> totalTransaction = [];
    List<int> totalPaidTransaction = [];
    List<int> totalDueTransaction = [];

    var data = await finalBillingDatabase.fetchAll();
    billingListData = data;

    for (var i = 0; i < billingListData.length; i++) {
      totalTransaction.add(int.parse(billingListData[i].totalAmount!));
      totalPaidTransaction.add(int.parse(billingListData[i].paidAmount!));
      totalDueTransaction.add(int.parse(billingListData[i].dueAmount!));
    }

    var productList = await productListDatabase.fetchAll();
    totalRevenue = totalTransaction.reduce((value, element) => value + element);
    totalPaid =
        totalPaidTransaction.reduce((value, element) => value + element);

    totalDue = totalDueTransaction.reduce(
      (value, element) => value + element,
    );
    dash.dashboardList[0].value = productList.length.toString();
    dash.dashboardList[1].value = billingListData.length.toString();
    dash.dashboardList[3].value = totalRevenue.toString();
    dash.dashboardList[4].value = totalPaid.toString();
    dash.dashboardList[5].value = totalDue.toString();

    print(totalPaid);
    print(totalRevenue);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
            children: [
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: dash.dashboardList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return StatsCardTile(data: dash, index: index);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextBuilder(
                      text: "Income Overview",
                      textOverflow: TextOverflow.clip,
                      fontSize: 13.0,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 90,
                      height: 25,
                      child: dropDown(items),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 270,
                child: Chart(),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CreateInvoiceTemplate()));
            },
            label: const TextBuilder(
              text: "Create Bill",
              textOverflow: TextOverflow.clip,
              fontSize: 10.0,
              color: Colors.white,
            ),
            icon: const Icon(
              Icons.add,
              size: 10,
              color: Colors.white,
            ),
          )),
    );
  }

  dropDown(List<String> items) {
    return DropdownButton(
      isDense: true,
      value: dropdownValue,
      iconSize: 12,
      padding: EdgeInsets.all(0),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(
          alignment: Alignment.center,
          value: items,
          child: TextBuilder(
            text: items,
            fontSize: 10,
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
    );
  }
}

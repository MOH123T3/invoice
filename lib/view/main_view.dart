import 'package:autorepair/imports.dart';
import 'package:autorepair/view/add_products/spare_part_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:autorepair/view/add_products/add_product.dart';

class MainView extends StatefulWidget {
  final int initRoute;
  const MainView({super.key, required this.initRoute});
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  List<Widget> tabs = const [
    Home(),
    Transaction(),
    SubSparePartList(),
    Settings()
  ];

  var items = ["Add Products", "View All Orders"];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initRoute;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [dropDown(items)],
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: TextBuilder(
          fontSize: 15,
          text: _currentIndex == 0
              ? 'Home'
              : _currentIndex == 1
                  ? "Transaction History"
                  : _currentIndex == 2
                      ? "Product List"
                      : "",
          color: Colors.black,
        ),
      ),
      drawer: const SideNav(),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 15,
        selectedFontSize: 10,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black26,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.t), label: 'Transaction'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded), label: 'Products'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  dropDown(List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          alignment: AlignmentDirectional.center,
          iconSize: 15,
          icon: const Icon(Icons.more_vert_outlined),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: TextBuilder(
                fontSize: 12,
                text: value,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value == "Add Products") {
              Get.to(const AddProduct());
            } else {
              Get.to(SpareParts());
            }
          },
        ),
      ),
    );
  }
}

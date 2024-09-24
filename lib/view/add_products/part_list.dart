import 'package:flutter/material.dart';
import 'package:autorepair/data/product_database.dart';
import 'package:autorepair/widgets/text/text_builder.dart';

class SpareParts extends StatefulWidget {
  const SpareParts({Key? key}) : super(key: key);

  @override
  _SparePartsState createState() => _SparePartsState();
}

class _SparePartsState extends State<SpareParts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextBuilder(
          text: "Spare Part List",
          textOverflow: TextOverflow.clip,
          fontSize: 15.0,
          color: Colors.black,
        ),
      ),
      body: const SparePartList(),
    );
  }
}

class SparePartList extends StatefulWidget {
  const SparePartList({super.key});

  @override
  State<StatefulWidget> createState() {
    return SparePartListState();
  }
}

class SparePartListState extends State<SparePartList> {
  final db = SparePartDatabase();
  List<SparePart> partList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            _header(),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: setupList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return _buildSparePartList(partList);
                }
              },
            ),
          ],
        ));
  }

  Widget _buildSparePartList(List<SparePart> partList) {
    print(partList);
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: partList.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: textData(partList[index].id.toString()),
            ),
            Expanded(
              flex: 2,
              child: textData(partList[index].partName.toString()),
            ),
            Expanded(
              flex: 2,
              child: textData("${partList[index].partPrice.toString()} Rs."),
            ),
            Expanded(
              flex: 2,
              child: textData(partList[index].partQuantity.toString()),
            ),
            Expanded(
              flex: 2,
              child: textData(partList[index].bikeModelNo.toString()),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    height: 25,
                    width: 100,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.delete,
                        size: 12,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        onDelete(partList[index].id!);
                      },
                    ),
                  ),
                  const Divider()
                ],
              ),
            )
          ],
        );
      },
    );
  }

  textData(text) {
    return Column(
      children: [
        Container(
          color: Colors.greenAccent,
          height: 25,
          alignment: Alignment.center,
          child: TextBuilder(
            text: text,
            maxLines: 4,
            textOverflow: TextOverflow.visible,
            fontSize: 10.0,
            color: Colors.black,
          ),
        ),
        const Divider()
      ],
    );
  }

  onDelete(int id) async {
    await db.removeProduct(id);
    db.fetchAll().then((carDb) => partList = carDb);
    setState(() {});
  }

  setupList() async {
    var partListData = await db.fetchAll();

    partList = partListData;
  }

  _header() {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        Expanded(
          flex: 1,
          child: headingTextData('Id'),
        ),
        Expanded(
          flex: 2,
          child: headingTextData('Name'),
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
          child: headingTextData('Model'),
        ),
        Expanded(flex: 2, child: headingTextData('Delete')),
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
}

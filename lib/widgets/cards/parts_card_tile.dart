// ignore_for_file: must_be_immutable

import 'package:autorepair/imports.dart';
import 'package:autorepair/model/part_model.dart';

class PartCardTile extends StatefulWidget {
  final PartModel? data;
  final Function()? onTap;

  PartCardTile({Key? key, this.data, this.onTap}) : super(key: key);

  @override
  State<PartCardTile> createState() => _PartCardTileState();
}

class _PartCardTileState extends State<PartCardTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: TextBuilder(
          text: widget.data!.quantity,
          fontSize: 18.0,
          color: Colors.black,
        ),
        subtitle: TextBuilder(
          text: '₹ ${widget.data!.amount}',
          fontSize: 12,
        ),
        leading: const Icon(
          Icons.settings,
          size: 30,
        ));
  }
}

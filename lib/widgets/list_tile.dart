import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vcredit_copy/constants.dart';

class ListTileCustoms extends StatelessWidget {
  // const ListTileCustoms({super.key});
  final Icon leadIcon;
  final Icon trailIcon;
  final String titleTxt;
  final String subTxt;
  ListTileCustoms(
      {required this.leadIcon,
      required this.subTxt,
      required this.titleTxt,
      required this.trailIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: ListTile(
        iconColor: Colors.blue,
        leading: leadIcon,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleTxt,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                subTxt,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        trailing: trailIcon,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vcredit_copy/constants.dart';
import 'package:vcredit_copy/widgets/list_tile.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reports')),
      body: Container(
        color: kAccentColor,
        // padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            ListTileCustoms(
                leadIcon: Icon(
                  Icons.wb_twilight_rounded,
                  // size: 40,
                ),
                subTxt: 'choose your language',
                titleTxt: 'Language',
                trailIcon: Icon(CupertinoIcons.arrow_right_circle_fill)),
            ListTileCustoms(
                leadIcon: Icon(
                  Icons.menu_book_outlined,
                ),
                titleTxt: 'Day Book',
                subTxt: 'All transactions for any date',
                trailIcon: Icon(CupertinoIcons.arrow_right_circle_fill)),
            ListTileCustoms(
                leadIcon: Icon(
                  Icons.menu_book_outlined,
                ),
                titleTxt: 'Day Book',
                subTxt: 'All transactions for any date',
                trailIcon: Icon(CupertinoIcons.arrow_right_circle_fill))
          ],
        ),
      ),
    );
  }
}

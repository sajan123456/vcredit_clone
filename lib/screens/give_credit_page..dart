import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vcredit_copy/constants.dart';
import 'package:vcredit_copy/screens/homepage.dart';

class GiveCredit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Get.off(HomePage());
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Give Credit / Udhaar',
            style: TextStyle(color: Colors.black),
          )),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border(
                      bottom:
                          BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
                      left:
                          BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
                      right:
                          BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
                      top: BorderSide(
                        color: Color.fromARGB(255, 212, 212, 212),
                      ),
                    ),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Customer Name'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border(
                      bottom:
                          BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
                      left:
                          BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
                      right:
                          BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
                      top: BorderSide(
                        color: Color.fromARGB(255, 212, 212, 212),
                      ),
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Amount'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: kAccentColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(Icons.edit_document),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Add Note')
                        ],
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: kAccentColor,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                            DateFormat("yyyy-MM-dd").format(DateTime.now()))),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Get.off(HomePage());
                  },
                  child: Text('Submit')),
            )
          ],
        ),
      ),
    );
  }
}

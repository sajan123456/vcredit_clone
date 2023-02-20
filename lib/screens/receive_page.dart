import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vcredit_copy/constants.dart';
import 'package:vcredit_copy/provider/crud_provider.dart';
import 'package:vcredit_copy/screens/homepage.dart';

class ReceivePage extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amtController = TextEditingController();

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
            'Receive',
            style: TextStyle(color: Colors.black),
          )),
      body: Form(
        key: _form,
        child: Consumer(
          builder: (context, ref, child) {
            final crudData = ref.watch(crudProvider);
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' Please provide name';
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          labelText: 'Enter Name',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          labelText: 'Amount',
                        ),
                        controller: amtController,
                        // inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' Please provide amount';
                          } else if (value.length > 8) {
                            return 'Max 8 Digits only';
                          }
                        },
                        keyboardType: TextInputType.phone,
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
                              child: Text(DateFormat("yyyy-MM-dd")
                                  .format(DateTime.now()))),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          _form.currentState!.save();
                          if (_form.currentState!.validate()) {
                            totalAmt += double.parse(amtController.text);
                            print('cehck amt');
                            final response = await ref
                                .read(crudProvider)
                                .addReceive(
                                    custName: nameController.text,
                                    custAmount: (amtController.text),
                                    date: DateFormat("yyyy-MM-dd")
                                        .format(DateTime.now()));

                            if (response != 'success') {
                              print('posting error');
                            } else {
                              Get.off(HomePage());
                            }
                          }
                        },
                        child: Text('Submit')),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vcredit_copy/constants.dart';
import 'package:vcredit_copy/provider/crud_provider.dart';
import 'package:vcredit_copy/screens/homepage.dart';

class ModifyPage extends StatefulWidget {
  final String postId;
  final String custName;
  final String custAmt;
  ModifyPage(
      {required this.postId, required this.custName, required this.custAmt});

  @override
  State<ModifyPage> createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  bool textEnable = false;
  void toggle() {
    textEnable = !textEnable;
  }

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
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Modify Data',
            style: TextStyle(color: Colors.black),
          )),
      body: Form(
        key: _form,
        child: Consumer(
          builder: (context, ref, child) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    enabled: false,
                    controller: nameController,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return ' Please provide name';
                    //   }
                    // },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14)),
                        labelText: widget.custName),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: textEnable ? true : false,
                    // enabled: true,
                    controller: amtController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' Please provide amount';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      labelText: widget.custAmt,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //delete
                      Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(kAccentColor)),
                            onPressed: () {
                              ref
                                  .read(crudProvider)
                                  .removeReceive(custId: widget.postId);

                              Get.off(HomePage());
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.grey),
                            )),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      //update

                      textEnable
                          ? Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  // setState(() {
                                  //   toggle();
                                  // }
                                  if (_form.currentState!.validate()) {
                                    final response = await ref
                                        .read(crudProvider)
                                        .updateReceive(
                                            custId: widget.postId,
                                            custName: widget.custName,
                                            custAmount: (amtController.text),
                                            date: DateFormat("yyyy-MM-dd")
                                                .format(DateTime.now()));

                                    if (response != 'success') {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              height: 50,
                                              width: 50,
                                              color: Colors.amber,
                                              child:
                                                  Text('something went wrong'));
                                        },
                                      );
                                      print('posting error');
                                    } else {
                                      // Navigator.pop(context);
                                      // Get.to(HomePage());
                                      Get.off(HomePage());
                                    }
                                  }
                                },
                                child: Text('Submit'),
                              ),
                            )
                          : Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      toggle();
                                    });
                                  },
                                  child: Text('Update')),
                            ),
                    ],
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

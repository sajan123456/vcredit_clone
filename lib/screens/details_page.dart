import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:vcredit_copy/constants.dart';
import 'package:vcredit_copy/screens/homepage.dart';
import 'package:vcredit_copy/screens/modify_page.dart';
import 'package:vcredit_copy/screens/receive_page.dart';

import 'give_credit_page..dart';

SampleItem? selectedMenu;

class DetailsPage extends StatefulWidget {
  // const DetailsPage({super.key});
  final postId;
  final titleTxt;
  final totalAmt;
  DetailsPage(
      {required this.titleTxt, required this.totalAmt, required this.postId});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool iconIndex = false;
  void toggle() {
    iconIndex = !iconIndex;
  }

  TextEditingController textarea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          extendBody: true,
          appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back)),
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: kAccentColor,
              elevation: 0,
              title: Text(
                widget.titleTxt,
                style: TextStyle(color: Colors.black87),
              )),
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 5, 20),
                height: 110,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.arrow_down_left_circle_fill,
                          size: 30,
                          color: Colors.greenAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'To Receive',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Rs. ${widget.totalAmt}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                height: 18,
                                image: AssetImage('assets/images/pdf.png'),
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'Send PDF',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    toggle();
                                  });
                                },
                                child: Icon(
                                  iconIndex
                                      ? CupertinoIcons.bell
                                      : CupertinoIcons.bell_fill,
                                  size: 20,
                                ),
                              ),
                              Text(
                                'Remind',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                          PopupMenuButton<SampleItem>(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            // icon: iconsLabel,
                            initialValue: selectedMenu,
                            // Callback that sets the selected popup menu item.
                            // onSelected: (SampleItem item) {
                            //   setState(() {
                            //     // selectedMenu = item;
                            //   });
                            // },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<SampleItem>>[
                              PopupMenuItem<SampleItem>(
                                height: 40,
                                value: SampleItem.itemOne,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        CupertinoIcons.hand_thumbsup_fill,
                                        size: 18,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Settle Fully',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem<SampleItem>(
                                height: 40,
                                value: SampleItem.itemTwo,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Image(
                                    //     image: AssetImage(
                                    //         'assets/images/message.png')),
                                    Icon(
                                      Icons.message,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Chat on WhatsApp',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<SampleItem>(
                                height: 40,
                                value: SampleItem.itemThree,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      CupertinoIcons.phone,
                                      size: 18,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Phone Call',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<SampleItem>(
                                height: 40,
                                value: SampleItem.itemTwo,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      CupertinoIcons.alarm,
                                      size: 18,
                                      color: Colors.brown,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Schedule Reminder',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: kAccentColor,
                height: 30,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  searchBar(Icon(Icons.filter_alt_outlined)),
                  //listview
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2, color: Colors.grey))),
                              child: Text('Date',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  )),
                            ),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2, color: Colors.red))),
                                    padding: EdgeInsets.all(5),
                                    width: 60,
                                    child: Center(
                                      child: Text(
                                        'Given',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2, color: Colors.blue))),
                                    padding: EdgeInsets.all(5),
                                    width: 80,
                                    child: Center(
                                      child: Text(
                                        'Received',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Get.offUntil(
                                // MaterialPageRoute(

                                //     builder: (context, ) => Calendar(), maintainState: true),

                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => ModifyPage(
                                        postId: widget.postId,
                                        custName: widget.titleTxt,
                                        custAmt: widget.totalAmt)),
                                ModalRoute.withName('/'));
                            // Get.off(ModifyPage(
                            //     postId: widget.postId,
                            //     custName: widget.titleTxt,
                            //     custAmt: widget.totalAmt));
                          },
                          child: Container(
                              child: detailCard(widget.totalAmt.toString())),
                        ),
                      ],
                    ),
                  )
                ]),
              ))
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(20),
            color: Colors.transparent,
            // height: 50,
            width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    textarea.clear();
                    Navigator.pop(context);
                    Get.to(ReceivePage());
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(8),
                      height: 50,
                      width: 140,
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.arrow_down_left,
                            color: Colors.white,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 60,
                            child: Text(
                              'Take Payment',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Get.to(GiveCredit());
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(8),
                      height: 50,
                      width: 140,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 80,
                            child: Text(
                              'Give Credit (Udhaar)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Icon(
                            CupertinoIcons.arrow_up_right,
                            color: Colors.white,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          )),
    );
  }

  Container detailCard(String amt) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.arrow_down_left,
                color: Colors.blue,
                size: 18,
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment'),
                  Text(
                    'Feb 2',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(amt),
              SizedBox(
                width: 5,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color.fromARGB(181, 224, 235, 255),
                    borderRadius: BorderRadius.circular(40)),
                child: Icon(
                  CupertinoIcons.arrowshape_turn_up_right_fill,
                  color: Colors.blueAccent,
                  size: 10,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container searchBar(Icon iconsLabel) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 70,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border(
                bottom: BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
                left: BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
                right: BorderSide(color: Color.fromARGB(255, 212, 212, 212)),
                top: BorderSide(color: Color.fromARGB(255, 212, 212, 212))),
          ),
          width: 250,
          child: TextFormField(
            controller: textarea,
            decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.search),
              hintStyle: TextStyle(fontSize: 13),
              hintText: 'Search Name or Phone Number',
            ),
          ),
        ),
        Container(
          // width: 60,
          // height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(1, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.all(2),
          child: PopupMenuButton<SampleItem>(
            icon: iconsLabel,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),

            initialValue: selectedMenu,
            // Callback that sets the selected popup menu item.
            onSelected: (SampleItem item) {
              setState(() {
                // selectedMenu = item;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
                height: 40,
                value: SampleItem.itemTwo,
                child: Text(
                  'Credit Given',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              PopupMenuItem<SampleItem>(
                height: 40,
                value: SampleItem.itemTwo,
                child: Text(
                  'Payment Received',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              PopupMenuItem<SampleItem>(
                height: 40,
                value: SampleItem.itemTwo,
                child: Text(
                  'Clear',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),

          // iconsLabel,
        )
      ]),
    );
  }
}

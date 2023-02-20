import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcredit_copy/constants.dart';
import 'package:vcredit_copy/provider/auth_provider.dart';
import 'package:vcredit_copy/provider/crud_provider.dart';
import 'package:vcredit_copy/screens/auth_service.dart';
import 'package:vcredit_copy/screens/details_page.dart';
import 'package:vcredit_copy/screens/give_credit_page..dart';
import 'package:vcredit_copy/screens/modify_page.dart';
import 'package:vcredit_copy/screens/receive_page.dart';
import 'package:vcredit_copy/screens/drawer%20pages/reports_page.dart';
import 'package:vcredit_copy/screens/drawer%20pages/settings_page.dart';

enum CardColor { green, red, no }

enum SampleItem { itemOne, itemTwo, itemThree }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  CardColor cardColor = CardColor.no;
  SampleItem? selectedMenu;
  TextEditingController textarea = TextEditingController();
  // late TabController _tabController;
  int _selectedIndex = 0;
  int pageIndex = 0;
  int totalAmtCalc = 0;

  @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  //   _tabController.addListener(() {
  //     setState(() {
  //       _selectedIndex = _tabController.index;
  //     });
  //     // print("Current Index: $_selectedIndex");
  //   });
  // }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  Widget build(BuildContext context) {
    //device width height
    // final actualHeight = MediaQuery.of(context).size.height;
    // final actualWidth = MediaQuery.of(context).size.width;
    //Consumer
    return Consumer(
      builder: (context, ref, child) {
        // final userData = ref.watch(singleUserStream); //watching current user
        final receiveData = ref.watch(receiveStream);

        return DefaultTabController(
          length: 2,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                extendBody: true,
                drawer: drawer(context), //Drawer,
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(color: Colors.black),
                      backgroundColor: kAccentColor,
                      elevation: 0,
                      title: Text(
                        "Business Name",
                        style: TextStyle(color: Colors.black),
                      ),
                      pinned: true,
                      expandedHeight: 280.0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          padding: EdgeInsets.fromLTRB(14, 20, 14, 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardColor = CardColor.green;
                                    });
                                  },
                                  child: Container(
                                    height: 80,
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),

                                            blurRadius: 2,
                                            offset: Offset(1,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                        color: cardColor == CardColor.green
                                            ? tealColor
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons
                                              .arrow_down_left_circle_fill,
                                          color: cardColor == CardColor.green
                                              ? Colors.white
                                              : tealColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'To Receive',
                                              style: TextStyle(
                                                  color: cardColor ==
                                                          CardColor.green
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                            Text(
                                              '$totalAmt',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: cardColor ==
                                                          CardColor.green
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cardColor = CardColor.red;
                                    });
                                  },
                                  child: Container(
                                    height: 80,
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),

                                            blurRadius: 2,
                                            offset: Offset(1,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                        color: cardColor == CardColor.red
                                            ? Colors.deepOrangeAccent
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons
                                              .arrow_up_right_circle_fill,
                                          color: cardColor == CardColor.red
                                              ? Colors.white
                                              : Colors.orange,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'To Pay',
                                              style: TextStyle(
                                                color:
                                                    cardColor == CardColor.red
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Rs 800',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    cardColor == CardColor.red
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(120),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: TabBar(
                                // controller: TabController,
                                labelColor: Colors.blue,
                                unselectedLabelColor: Colors.grey,
                                indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        width: 5.0, color: Colors.blue),
                                    insets:
                                        EdgeInsets.symmetric(horizontal: 16.0)),
                                tabs: [
                                  Tab(text: 'Customers'),
                                  Tab(text: 'Credit/ Udhaar'),
                                ],
                              ),
                            ),
                            _selectedIndex == 1
                                ? searchBar(
                                    Icon(
                                      Icons.sort,
                                      color: Colors.black54,
                                    ),
                                  )
                                : searchBar(
                                    Icon(
                                      Icons.sort,
                                      color: Colors.black54,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    SliverFillRemaining(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        color: Colors.white,
                        child: TabBarView(
                          // controller: _tabController,
                          // physics: NeverScrollableScrollPhysics(),
                          children: [
                            Container(
                              child: receiveData.when(
                                data: (data) {
                                  return ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // Get.to(DetailsPage(
                                              //     postId: data[index].id,
                                              //     titleTxt:
                                              //         data[index].custName,
                                              //     totalAmt:
                                              //         data[index].custAmount));
                                              Get.offUntil(
                                                  // MaterialPageRoute(

                                                  //     builder: (context, ) => Calendar(), maintainState: true),

                                                  PageRouteBuilder(
                                                      pageBuilder: (_, __,
                                                              ___) =>
                                                          ModifyPage(
                                                              postId:
                                                                  data[index]
                                                                      .id,
                                                              custAmt: data[
                                                                      index]
                                                                  .custAmount,
                                                              custName: data[
                                                                      index]
                                                                  .custName)),
                                                  ModalRoute.withName('/'));
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              padding: EdgeInsets.all(5),
                                              // height: 20,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data[index].custName,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Text(
                                                        data[index].date,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        data[index].custAmount,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.orange),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .notification_add_outlined,
                                                        color: Colors.grey,
                                                        size: 23,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            height: 2,
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                error: (error, stackTrace) => Center(
                                  child: Text('$error'),
                                ),
                                loading: () => Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            Container(
                              child: receiveData.when(
                                data: (data) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 2,
                                                          color: Colors.grey))),
                                              child: Text('Customer',
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
                                                                width: 2,
                                                                color: Colors
                                                                    .red))),
                                                    padding: EdgeInsets.all(5),
                                                    width: 60,
                                                    child: Center(
                                                      child: Text(
                                                        'Given',
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                width: 2,
                                                                color: Colors
                                                                    .blue))),
                                                    padding: EdgeInsets.all(5),
                                                    width: 80,
                                                    child: Center(
                                                      child: Text(
                                                        'Received',
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          padding: EdgeInsets.all(0),
                                          // scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: data.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.offUntil(
                                                        // MaterialPageRoute(

                                                        //     builder: (context, ) => Calendar(), maintainState: true),

                                                        PageRouteBuilder(
                                                            pageBuilder: (_, __, ___) => ModifyPage(
                                                                postId:
                                                                    data[index]
                                                                        .id,
                                                                custAmt: data[
                                                                        index]
                                                                    .custAmount,
                                                                custName: data[
                                                                        index]
                                                                    .custName)),
                                                        ModalRoute.withName(
                                                            '/'));

                                                    // Get.off(ModifyPage(
                                                    //     postId: data[index].id,
                                                    //     custAmt: data[index]
                                                    //         .custAmount,
                                                    //     custName: data[index]
                                                    //         .custName));
                                                  },
                                                  child: Container(
                                                    // margin: EdgeInsets.only(
                                                    //     bottom: 10),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8),
                                                    // height: 20,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .arrow_down_left,
                                                              size: 18,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  data[index]
                                                                      .custName,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  data[index]
                                                                      .date,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              data[index]
                                                                  .custAmount
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .orange),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              decoration: BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          181,
                                                                          224,
                                                                          235,
                                                                          255),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              40)),
                                                              child: Icon(
                                                                CupertinoIcons
                                                                    .arrowshape_turn_up_right_fill,
                                                                color: Colors
                                                                    .blueAccent,
                                                                size: 10,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 2,
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                error: (error, stackTrace) => Center(
                                  child: Text('$error'),
                                ),
                                loading: () => Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
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
          ),
        );
      },
    );
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: kPrimaryColor,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                //photo
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(40),
                //   child: Image(
                //       width: 50,
                //       height: 50,
                //       image: NetworkImage(
                //         FirebaseAuth.instance.currentUser!.photoURL!,
                //       )),
                // ),
                CircleAvatar(
                  maxRadius: 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                //details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'chek',
                      // data.firstName!,
                      FirebaseAuth.instance.currentUser!.displayName!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      // data.metadata!['email'],
                      FirebaseAuth.instance.currentUser!.email!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      // width: 70,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 111, 185),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        'Edit Company >',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(ReportsPage());
            },
            child: ListTile(
              leading: Icon(
                Icons.show_chart_rounded,
                color: kPrimaryColor,
              ),
              title: Text(
                'Reports',
                style: (TextStyle(fontSize: 16)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(SettingsPage());
            },
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: kPrimaryColor,
              ),
              title: Text(
                'Settings',
                style: (TextStyle(fontSize: 16)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 230,
                        width: 280,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ListTile(
                              leading: Image(
                                  width: 30,
                                  height: 30,
                                  image:
                                      AssetImage('assets/images/whatsapp.png')),
                              title: Text('Whatsapp'),
                            ),
                            ListTile(
                              leading: Image(
                                  width: 30,
                                  height: 30,
                                  image: AssetImage('assets/images/gmail.png')),
                              title: Text('Email'),
                            ),
                            ListTile(
                              leading: Image(
                                  width: 30,
                                  height: 30,
                                  image:
                                      AssetImage('assets/images/message.png')),
                              title: Text('Message'),
                            ),
                            ListTile(
                              leading: Image(
                                  width: 30,
                                  height: 30,
                                  image: AssetImage('assets/images/call.png')),
                              title: Text('Call'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.call,
                color: kPrimaryColor,
              ),
              title: Text(
                'Customer Support',
                style: (TextStyle(fontSize: 16)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              bottomPopMenu(context);
            },
            child: ListTile(
              leading: Icon(
                CupertinoIcons.arrowshape_turn_up_right_fill,
                color: kPrimaryColor,
              ),
              title: Text(
                'Share Vcredit',
                style: (TextStyle(fontSize: 16)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 150,
                        width: 280,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Do you like our app?',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                Icon(
                                  Icons.star_border_outlined,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                'Later',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.star_border_outlined,
                color: kPrimaryColor,
              ),
              title: Text(
                'Rate Us',
                style: (TextStyle(fontSize: 16)),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              launchUrl(Uri.parse("http://www.youtube.com"),
                  mode: LaunchMode.externalApplication);
            },
            child: ListTile(
              leading: Image(
                  height: 25, image: AssetImage('assets/images/youtube.png')),
              title: Text(
                'How to use Vcredit',
                style: (TextStyle(fontSize: 16)),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     // ref.read(authProvider).userLogout();
          //     setState(() {
          //       Navigator.pop(context);
          //     });

          //     AuthService().signOut();
          //   },
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.logout_rounded,
          //       color: kPrimaryColor,
          //     ),
          //     title: Text(
          //       'Logout',
          //       style: (TextStyle(fontSize: 16)),
          //     ),
          //   ),
          // ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Future<dynamic> bottomPopMenu(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 150,
          padding: EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Share Vcredit',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/images/whatsapp.png',
                        ),
                        height: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('WhatsApp')
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.message,
                        size: 30,
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('SMS')
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.more_horiz,
                        color: Colors.green,
                        size: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('More')
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Container searchBar(Icon iconsLabel) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 15),
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
          width: 260,
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
          width: 40,
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            icon: iconsLabel,
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
                value: SampleItem.itemOne,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.arrow_down_left_circle_fill,
                        color: Colors.greenAccent,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'To Receive(High to low)',
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
                    Icon(
                      CupertinoIcons.arrow_up_right_circle_fill,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'To Pay(High to low)',
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
                      CupertinoIcons.textformat_abc_dottedunderline,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Name(A-Z)',
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
                      CupertinoIcons.multiply,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Clear',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
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

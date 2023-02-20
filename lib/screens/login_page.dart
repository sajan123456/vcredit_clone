import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vcredit_copy/screens/auth_service.dart';

class LoginPage extends StatefulWidget {
  // final ConnectivityResult snapshot;
  // const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map _source = {ConnectivityResult.none: false};
  // final MyConnectivity _connectivity = MyConnectivity.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            // elevation: 3,
            borderRadius: BorderRadius.circular(20),
            child: StreamBuilder<ConnectivityResult>(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, snapshot) {
                return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.6),
                        //     spreadRadius: 3,
                        //     blurRadius: 4,
                        //     offset: Offset(2, 4), // changes position of shadow
                        //   ),
                        // ],
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)),
                    height: 200,
                    width: 300,
                    // padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Sign in with Google',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Image(
                              // width: 80,
                              height: 40,
                              image: AssetImage('assets/images/google.png'),
                              fit: BoxFit.contain,
                            )
                          ],
                        ),
                        Container(
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () {
                                AuthService().signInWithGoogle();
                              },
                              //   try {
                              //     final result = await InternetAddress.lookup(
                              //         'https://www.youtube.com/');
                              //     if (result.isNotEmpty &&
                              //         result[0].rawAddress.isNotEmpty) {

                              //     }
                              //   } on SocketException catch (_) {
                              //     Center(
                              //       child: Container(
                              //         height: 50,
                              //         width: 50,
                              //         child: Text('No Internet.'),
                              //       ),
                              //     );
                              //   }
                              // },
                              //   if (ConnectivityResult ==
                              //       ConnectionState.none) {
                              //     showDialog(
                              //       context: context,
                              //       builder: (context) {
                              //         return Center(
                              //           child: Container(
                              //             height: 50,
                              //             width: 50,
                              //             child: Text('No Internet.'),
                              //           ),
                              //         );
                              //       },
                              //     );
                              //   } else {
                              //     AuthService().signInWithGoogle();
                              //   }
                              // },
                              child: Text('Sign in')),
                        )
                      ],
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }
}

// class MyConnectivity {
//   MyConnectivity._();

//   static final _instance = MyConnectivity._();
//   static MyConnectivity get instance => _instance;
//   final _connectivity = Connectivity();
//   final _controller = StreamController.broadcast();
//   Stream get myStream => _controller.stream;

//   void initialise() async {
//     ConnectivityResult result = await _connectivity.checkConnectivity();
//     _checkStatus(result);
//     _connectivity.onConnectivityChanged.listen((result) {
//       _checkStatus(result);
//     });
//   }

//   void _checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//     _controller.sink.add({result: isOnline});
//   }

//   void disposeStream() => _controller.close();
// }

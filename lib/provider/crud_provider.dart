import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcredit_copy/models/receiveTotal.dart';
import 'package:vcredit_copy/models/receive_data.dart';

final crudProvider = Provider((ref) => CrudProvider());
final receiveStream = StreamProvider((ref) => CrudProvider().getReceiveData());
// final totalreceiveStream =
//     StreamProvider((ref) => CrudProvider().getTotalReceiveData());

class CrudProvider {
  final receiveDb = FirebaseFirestore.instance.collection('receiveData');
  // final receiveTotal = FirebaseFirestore.instance.collection('totalReceived');

  Future<String> addReceive(
      {required String custName,
      required String custAmount,
      required String date}) async {
    try {
      await receiveDb
          .add({'custName': custName, 'custAmount': custAmount, 'date': date});
    } on FirebaseException catch (err) {
      return '${err.message}';
    }
    return 'success';
  }

  // Future<String> addTotalReceive({
  //   required int totalReceived,
  // }) async {
  //   try {
  //     await receiveTotal.add({'totalReceived': totalReceived});
  //   } on FirebaseException catch (err) {
  //     return '${err.message}';
  //   }
  //   return 'success';
  // }

  Future<String> updateReceive(
      {required String custName,
      required String custId,
      required String custAmount,
      required String date}) async {
    try {
      await receiveDb.doc(custId).update(
          {'custName': custName, 'custAmount': custAmount, 'date': date});
    } on FirebaseException catch (err) {
      return '${err.message}';
    }
    return 'success';
  }

  Future<String> removeReceive({
    required String custId,
  }) async {
    try {
      await receiveDb.doc(custId).delete();
    } on FirebaseException catch (err) {
      return '${err.message}';
    }
    return 'success';
  }

  Stream<List<ReceiveData>> getReceiveData() {
    try {
      final response = receiveDb.snapshots().map((event) {
        return event.docs.map((e) {
          final json = e.data();
          return ReceiveData(
              id: e.id,
              custAmount: json['custAmount'],
              custName: json['custName'],
              date: json['date']);
        }).toList();
      });

      return response;
    } on FirebaseException catch (err) {
      throw '${err.message}';
    }
  }

  // Stream<List<TotalReceived>> getTotalReceiveData() {
  //   try {
  //     final response = receiveTotal.snapshots().map((event) {
  //       return event.docs.map((e) {
  //         final json = e.data();
  //         return TotalReceived(
  //           id: e.id,
  //           totalReceived: json['totalReceived'],
  //         );
  //       }).toList();
  //     });

  //     return response;
  //   } on FirebaseException catch (err) {
  //     throw '${err.message}';
  //   }
  // }
}

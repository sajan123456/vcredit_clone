import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcredit_copy/provider/auth_provider.dart';

import 'package:vcredit_copy/screens/homepage.dart';

class StatusPage extends StatelessWidget {
  // const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final authData = ref.watch(authStream);
          return authData.when(
            data: (data) {
              if (data == null) {
                return HomePage();
              } else {
                return HomePage();
              }
            },
            error: (error, stackTrace) {
              return Center(child: Text('$error'));
            },
            loading: () => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

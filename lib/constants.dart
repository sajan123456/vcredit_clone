import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final String kYoutubeIcon =
    'https://th.bing.com/th/id/OIP.UVryA4nuAoLPpAzIekGZwAHaHa?pid=ImgDet&rs=1';
final Color kPrimaryColor = Color.fromARGB(255, 24, 137, 254);
final Color kAccentColor = Color.fromARGB(255, 230, 242, 254);
String dropdownvalue = 'English';

// List of items in our dropdown menu
var items = [
  'English',
  'Hindi',
  'Nepali',
  'Arabic',
  'Chinese',
];
final dateValue = DateFormat("yyyy-MM-dd").format(DateTime.now());

double totalAmt = 100;

Color tealColor = Color.fromARGB(255, 34, 201, 184);

import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadQuotesFromTxt() async {
  final firestore = FirebaseFirestore.instance;

  final raw = await rootBundle.loadString('assets/quotes.txt');
  final lines = raw
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();

  for (final quote in lines) {
    await firestore.collection('quotes').add({
      'text': quote,
      // 'category': 'life', // or leave out if unused
    });
  }

  print('✅ Uploaded ${lines.length} quotes to Firestore.');
}

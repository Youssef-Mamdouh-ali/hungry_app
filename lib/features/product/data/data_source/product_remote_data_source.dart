import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRemoteDataSource {
  final FirebaseFirestore firestore;

  ProductRemoteDataSource(this.firestore);

  Future<List<Map<String, dynamic>>> getToppings() async {
    final snapshot = await firestore
        .collection('toppings')
        .get();

    return snapshot.docs
        .map((doc) => doc.data())
        .toList();
  }

  Future<List<Map<String, dynamic>>> getSideOptions() async {
    final snapshot = await firestore
        .collection('side_options')
        .get();

    return snapshot.docs
        .map((doc) => doc.data())
        .toList();
  }
}
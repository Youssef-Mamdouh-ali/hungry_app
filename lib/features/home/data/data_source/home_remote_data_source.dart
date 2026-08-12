import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hungry_app/features/home/data/models/product_model.dart';

class HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSource(this.firestore);

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await firestore
        .collection('products')
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }
}
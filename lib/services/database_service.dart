import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestoreexample/models/product_model.dart';

class DatabaseService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static String productFolder = 'products';

  static Future createProduct(ProductModel model) async {
    var doc = firestore.collection(productFolder).doc();
    model.uid = doc.id;
    await doc.set(model.toJson());
  }

  static Future updateProduct(ProductModel model) async {
    await firestore.collection(productFolder).doc(model.uid).update(model.toJson());
  }

  static Future delProduct(ProductModel model) async {
    await firestore.collection(productFolder).doc(model.uid).delete();
  }


  static Future<List<ProductModel>> getProducts() async {
    var data = await firestore.collection(productFolder).get();

    return data.docs.map((e) => ProductModel.fromJson(e.data()),).toList();
  }



}
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product_model.dart';
import 'product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final CollectionReference<ProductModel> _db =
      FirebaseFirestore.instance.collection('products').withConverter<ProductModel>(
            fromFirestore: ProductModel.fromFirestore,
            toFirestore: (model, _) => model.toFirestore(),
          );

  @override
  Future<void> addProduct(ProductModel model) async {
    await _db.add(model);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _db.doc(id).delete();
  }

  @override
  Future<void> updateProduct(ProductModel model) async {
    if (model.id == null) throw Exception("Product ID is required for update");
    await _db.doc(model.id).set(model);
  }

  @override
  Future<ProductModel?> getProduct(String id) async {
    final data = await _db.doc(id).get();
    return data.data();
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final data = await _db.get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<List<ProductModel>> getProductByCategory(String category) async {
    final data = await _db.where('category', isEqualTo: category).get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<List<ProductModel>> searchProduct(String name) async {
    final data = await _db
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThanOrEqualTo: '$name\uf8ff')
        .get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<List<ProductModel>> filterProduct(double price) async {
    final data = await _db.where('price', isLessThanOrEqualTo: price).get();
    return data.docs.map((doc) => doc.data()).toList();
  }
}

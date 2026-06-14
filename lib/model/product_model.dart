import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String? name;
  double? price;
  String? description;
  String? category;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String?,
      name: map['name'] as String?,
      price: (map['price'] as num?)?.toDouble(),
      description: map['description'] as String?,
      category: map['category'] as String?,
    );
  }

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
      id: snapshot.id,
      name: data?['name'] as String?,
      price: (data?['price'] as num?)?.toDouble(),
      description: data?['description'] as String?,
      category: data?['category'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (price != null) "price": price,
      if (description != null) "description": description,
      if (category != null) "category": category,
    };
  }
}

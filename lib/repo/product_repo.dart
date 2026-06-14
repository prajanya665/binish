import '../model/product_model.dart';

abstract class ProductRepo {
  Future<void> addProduct(ProductModel model);
  Future<void> deleteProduct(String id);
  Future<void> updateProduct(ProductModel model);
  Future<ProductModel?> getProduct(String id);
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductByCategory(String category);
  Future<List<ProductModel>> searchProduct(String name);
  Future<List<ProductModel>> filterProduct(double price);
}

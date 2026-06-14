import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../repo/product_repo.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepo _productRepo;
  ProductViewModel({required ProductRepo productRepo}) : _productRepo = productRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ProductModel? _selectedProduct;
  ProductModel? get selectedProduct => _selectedProduct;

  List<ProductModel> _categoryProducts = [];
  List<ProductModel> get categoryProducts => _categoryProducts;

  List<ProductModel> _searchResults = [];
  List<ProductModel> get searchResults => _searchResults;

  List<ProductModel> _filteredProducts = [];
  List<ProductModel> get filteredProducts => _filteredProducts;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchAllProducts() async {
    setLoading(true);
    try {
      _products = await _productRepo.getAllProducts();
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchProductById(String id) async {
    setLoading(true);
    try {
      _selectedProduct = await _productRepo.getProduct(id);
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    setLoading(true);
    try {
      _categoryProducts = await _productRepo.getProductByCategory(category);
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> searchProducts(String name) async {
    setLoading(true);
    try {
      _searchResults = await _productRepo.searchProduct(name);
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> filterProducts(double price) async {
    setLoading(true);
    try {
      _filteredProducts = await _productRepo.filterProduct(price);
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> addProduct(ProductModel product) async {
    setLoading(true);
    try {
      await _productRepo.addProduct(product);
      await fetchAllProducts();
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    setLoading(true);
    try {
      await _productRepo.updateProduct(product);
      await fetchAllProducts();
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteProduct(String id) async {
    setLoading(true);
    try {
      await _productRepo.deleteProduct(id);
      _products.removeWhere((element) => element.id == id);
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setLoading(false);
    }
  }
}

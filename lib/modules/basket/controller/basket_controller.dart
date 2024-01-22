import 'package:atlobha/modules/categories/models/category_model.dart';
import 'package:get/get.dart';

class BasketController extends GetxController {

  Map<int, BasketItem> _products = {};

  void clean(){
    _products = {};
  }

  void addProduct(Product product, int count) {
    if (count > 0) {
      _products[product.id] = BasketItem(product: product, quantity: count);
    } else {
      _products.remove(product.id);
    }
    update();
  }

  void removeProduct(int productId) {
    _products.remove(productId);
    update();
  }

  void incrementProductCount(int productId) {
    if (_products.containsKey(productId)) {
      _products[productId]!.quantity++;
      update();
    }
  }

  void decrementProductCount(int productId) {
    if (_products.containsKey(productId) && _products[productId]!.quantity > 1) {
      _products[productId]!.quantity--;
      update();
    } else {
      removeProduct(productId);
    }
    update();
  }

  Map<int, BasketItem> get products => _products;
}


class BasketItem {
  final Product product;
  int quantity;

  BasketItem({required this.product, required this.quantity});
}

import 'package:e_shop/models/product_model.dart'; // Import your product model

class CartItem {
  final Product product;
   int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart {
  final List<CartItem> items;

  Cart({this.items = const []});

  void addToCart(Product product) {
    // Check if the product already exists in the cart
    bool found = false;
    for (var item in items) {
      if (item.product.id == product.id) {
        found = true;
        item.quantity++;
        break;
      }
    }

    // If product is not found, add it to the cart with quantity 1
    if (!found) {
      items.add(CartItem(product: product));
    }
  }

  void removeFromCart(Product product) {
    items.removeWhere((item) => item.product.id == product.id);
  }

  int totalItems() {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
}
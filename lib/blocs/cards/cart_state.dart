
import 'package:e_shop/models/product_model.dart';

abstract class CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Product> products;

  CartLoaded(this.products);
}

class CartError extends CartState {
  final String error;

  CartError(this.error);
}

// ignore_for_file: override_on_non_overriding_member

import 'package:bloc/bloc.dart';
import 'package:e_shop/models/product_model.dart'; // Adjust import as per your product model
import './cart_event.dart';
import './cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Product> _cartItems = [];

  CartBloc() : super(CartLoaded([])) {
    on<AddToCart>(_mapAddToCartToState);
    on<RemoveFromCart>(_mapRemoveFromCartToState);
  }


   Future<void> _mapAddToCartToState(AddToCart event, Emitter<CartState> emit) async {
    try {
      _cartItems.add(event.product);
      emit (CartLoaded(List.from(_cartItems)));
    } catch (e) {
      emit (CartError('Failed to add item to cart'));
    }
  }

  Future<void> _mapRemoveFromCartToState(RemoveFromCart event,Emitter<CartState> emit) async {
    try {
      _cartItems.remove(event.product);
      emit (CartLoaded(List.from(_cartItems)));
    } catch (e) {
      emit (CartError('Failed to remove item from cart'));
    }
  }


  
}
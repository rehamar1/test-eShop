
import 'package:e_shop/blocs/cards/cart_state.dart';
import 'package:e_shop/notifications/notification_service.dart';
import 'package:e_shop/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shop/blocs/products/product_bloc.dart';
import 'package:e_shop/models/product_model.dart';
import 'package:e_shop/screens/product_detail_screen.dart';
import 'package:e_shop/screens/cart_screen.dart';
import 'package:e_shop/services/auth_service.dart';
import 'package:e_shop/blocs/cards/cart_bloc.dart';

import '../blocs/cards/cart_event.dart'; // Import CartBloc

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
   final NotificationService notificationService =NotificationService();
  final ScrollController _scrollController = ScrollController();
  late List<Product> _products;
  late List<Product> _filteredProducts;
  int _skip = 0;
  final int _limit = 10;
  String _searchQuery = '';
  double _minPrice = 0;
  double _maxPrice = 1000;
  
  // AuthService instance
  final AuthService _authService = AuthService();
  
  // Cart instance
   CartBloc _cartBloc = CartBloc();

  @override
  void initState() {
                  notificationService.showNotification(
                'Special Offer',
                'Check out our latest promotions!',
              );
    super.initState();
    _products = [];
    _filteredProducts = [];
    _fetchProducts();
    _scrollController.addListener(_onScroll);
    
    // Initialize CartBloc
    _cartBloc = BlocProvider.of<CartBloc>(context);
  }

  void _fetchProducts() {
    context.read<ProductBloc>().add(FetchProducts(skip: _skip, limit: _limit));
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _skip += _limit;
      _fetchProducts();
    }
  }

  void _filterProducts(List<Product> products) {
    setState(() {
      _filteredProducts = products.where((product) {
        final bool matchesQuery = product.title.toLowerCase().contains(_searchQuery.toLowerCase());
        final bool matchesPrice = product.price >= _minPrice && product.price <= _maxPrice;
        return matchesQuery && matchesPrice;
      }).toList();
    });
  }
  
  // Logout function
  void _logout() async {
    await _authService.signOut();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    AuthScreen()), (Route<dynamic> route) => false);
  }

 void _addToCart(BuildContext context, Product product) {
    context.read<CartBloc>().add(AddToCart(product));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product added to cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Badge(
            // Custom widget or package to show badge count
            label: Text('${state.products.length}'),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
          );
        } else {
          return IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
          );
        }
      },
    ),
          IconButton(
            icon: Icon(Icons.logout_rounded),
            onPressed: _logout,
          ),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductLoaded) {
            _products.addAll(state.products);
            _filterProducts(_products);
          }
        },
        builder: (context, state) {
          if (state is ProductLoading && _products.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                        _filterProducts(_products);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Price Range:'),
                      RangeSlider(
                        values: RangeValues(_minPrice, _maxPrice),
                        min: 0,
                        max: 1000,
                        divisions: 100,
                        labels: RangeLabels('\$${_minPrice.toStringAsFixed(0)}', '\$${_maxPrice.toStringAsFixed(0)}'),
                        onChanged: (values) {
                          setState(() {
                            _minPrice = values.start;
                            _maxPrice = values.end;
                            _filterProducts(_products);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return _buildProductItem(product);
                    },
                  ),
                ),
              ],
            );
          } else if (state is ProductError) {
            return Center(child: Text('Failed to load products'));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    final DateTime now = DateTime.now();
    final DateTime createdDate = product.meta.createdAt;
    final bool isNew = now.difference(createdDate).inDays <= 3;
    final bool isOnSale = product.discountPercentage > 0;
    final bool isFlashSale = product.price < 10;

    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(product.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$${product.price.toStringAsFixed(2)}'),
            if (isNew) Chip(label: Text('New', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
            if (isFlashSale) Chip(label: Text('Flash Sale', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
            if (isOnSale && !isFlashSale) Chip(label: Text('Sale: ${product.discountPercentage}% off', style: TextStyle(color: Colors.white)), backgroundColor: Colors.orange),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart),
          onPressed: () {
             _addToCart(context, product);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

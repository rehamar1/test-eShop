import 'package:e_shop/notifications/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cards/cart_bloc.dart';
import 'blocs/products/product_bloc.dart';
import 'repositories/product_repository.dart';
import 'screens/login_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  await NotificationService.initialize(); // Initialize notification service
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(productRepository: ProductRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'E-Shop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthScreen(),
      ),
    );
  }
}
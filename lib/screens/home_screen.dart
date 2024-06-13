import 'package:flutter/material.dart';
import '../notifications/notification_service.dart';

class HomeScreen extends StatelessWidget {
  final NotificationService notificationService;

  HomeScreen({required this.notificationService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              notificationService.showNotification(
                'Special Offer',
                'Check out our latest promotions!',
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to E-Shop!'),
      ),
    );
  }
}
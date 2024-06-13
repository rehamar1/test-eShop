import 'package:e_shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime createdDate = product.meta.createdAt;
    final bool isNew = now.difference(createdDate).inDays <= 3;
    final bool isOnSale = product.discountPercentage > 0;
    final bool isFlashSale = product.price < 10;

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.thumbnail,
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              product.title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
                if (isNew) Chip(label: Text('New', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
                if (isFlashSale) Chip(label: Text('Flash Sale', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
                if (isOnSale && !isFlashSale) Chip(label: Text('Sale: ${product.discountPercentage}% off', style: TextStyle(color: Colors.white)), backgroundColor: Colors.orange),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              product.description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Dimensions:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Width: ${product.dimensions.width} cm\n'
              'Height: ${product.dimensions.height} cm\n'
              'Depth: ${product.dimensions.depth} cm',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Availability: ${product.availabilityStatus}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Brand: ${product.brand}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'SKU: ${product.sku}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Reviews:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: product.reviews.length,
              itemBuilder: (context, index) {
                final review = product.reviews[index];
                return ListTile(
                  title: Text('${review.reviewerName} - ${review.rating} stars'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.comment),
                      SizedBox(height: 4.0),
                      Text('Date: ${DateFormat('yyyy-MM-dd').format(review.date)}'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

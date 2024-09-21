import 'package:flutter/material.dart';
import 'package:module13_project_curdapp/screens/delete_product_screen.dart';

import '../models/product.dart';
import '../screens/update_product_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key, required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: Colors.white,
      title: Text(product.productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Code: ${product.productCode}"),
          Text("Price: ${product.unitPrice}"),
          Text("Quantity: ${product.quantity}"),
          Text("Total Price: ${product.totalPrice}"),
          Divider(),
          ButtonBar(
            children: [

              //Edit Button
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // peramitar nisi tai id pass hocche
                      builder: (context) => UpdateProductScreen(productId: product.id ),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
                label: const Text("Edit"),
              ),

              //Delete Button
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // peramitar nisi tai id pass hocche
                      builder: (context) => DeleteProductScreen(productId: product.id ),
                    ),
                  );
                },
                icon: Icon(Icons.delete,color: Colors.red,),
                label: const Text("Delete",style: TextStyle(
                    color: Colors.red
                ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
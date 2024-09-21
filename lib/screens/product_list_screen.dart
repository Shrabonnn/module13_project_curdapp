import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:module13_project_curdapp/screens/add_new_product_screen.dart';

import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  bool _inProgress =false;
  List<Product> productlist =[];

  //life cycle
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product list"),
        actions: [
          IconButton(onPressed: (){
            getProductList();
          }, icon: const Icon(Icons.refresh)),
        ],
      ),
      body:_inProgress? Center(
        child: CircularProgressIndicator(),
      ) :Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
            itemCount: productlist.length,
            itemBuilder: (context, index) {
              return ProductItem(
                product: productlist[index],
              );
            },
          separatorBuilder:(context, index) {
            return SizedBox(height: 16,);
          }
        ),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewProductScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

    );
  }


  Future<void>getProductList() async {

    _inProgress =true;
    setState(() {

    });
    //request
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');

    //response
    Response response = await get(uri);
    print(response);
    print(response.statusCode);
    print(response.statusCode);
    print(response.body);

    //need to decode
    if(response.statusCode ==200) {
      productlist.clear();
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // status , data ->> this values are from data
      for(var item in jsonResponse['data']){
        Product product = Product(id: item['_id'],
            productName: item['ProductName']?? '',
            productCode: item['ProductCode']?? '',
            prodcutImage: item['img']?? '',
            unitPrice: item['UnitPrice']?? '',
            quantity: item['Qty']?? '',
            totalPrice: item['TotalPrice']?? '',
            createdAt: item['CreatedDate']?? '');
        productlist.add(product);
      }
    }
    _inProgress =false;
    setState(() {

    });
  }



}



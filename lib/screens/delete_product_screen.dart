import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';


class DeleteProductScreen extends StatefulWidget {

  // id wise update hobe tai id neya lagse
  final String productId;
  const DeleteProductScreen({super.key, required this.productId});



  @override
  State<DeleteProductScreen> createState() => _DeleteProductScreenState();
}


class _DeleteProductScreenState extends State<DeleteProductScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inprogress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Product"),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form method extraction
          child: _buildNewProductForm(),
        ),
      ) ,
    );
  }

  Widget _buildNewProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            "Are you sure you want to delete this product?",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16,),
          _inprogress?Center(child:CircularProgressIndicator()):
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(double.maxFinite)),
            onPressed:  _onDeleteButtonPressed,
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _onDeleteButtonPressed()
  {
    if(_formKey.currentState!.validate()){
      _deleteProduct();

    }

  }

  Future<void> _deleteProduct() async {
    _inprogress =true;
    setState(() {

    });

    //tried both post and get method but both way it gives 404 error don't know why
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/${widget.productId}');
    Response response = await delete(uri);

    //post method
    /*Map<String ,dynamic> requestbody= {
      "productId": widget.productId,

    };
    Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestbody),
    );*/

    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200 || response.statusCode ==204){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product deleted successfully')));
      Navigator.of(context).pop();
    }
    else {
      // Handle non-200 responses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product: ${response.body}')),
      );
    }
    _inprogress =false;
    setState(() {

    });


  }


  //dispose
  @override
  void dispose() {
    super.dispose();
  }
}


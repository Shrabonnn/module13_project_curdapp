import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _productNameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inprogress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
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
            TextFormField(
              controller: _productNameTEController,
              decoration: const InputDecoration(
                hintText: "Name",
                labelText: "Product Name"
              ),
              validator : (String? value){
                if(value == null || value!.isEmpty)
                  {
                    return "Enter a valid value";
                  }
                else
                {
                  return null;
                }
              }

            ),
            TextFormField(
              controller: _unitPriceTEController,
              decoration: InputDecoration(
                hintText: "Price",
                labelText: "Unit Price"
              ),
                validator : (String? value){
                  if(value == null || value!.isEmpty)
                  {
                    return "Enter a valid value";
                  }
                  else
                  {
                    return null;
                  }
                }
            ),
            TextFormField(
              controller: _totalPriceTEController,
              decoration: InputDecoration(
                hintText: "Total Price",
                labelText: "Total Price"
              ),
                validator : (String? value){
                  if(value == null || value!.isEmpty)
                  {
                    return "Enter a valid value";
                  }
                  else
                  {
                    return null;
                  }
                }
            ),
            TextFormField(
              controller: _imageTEController,
              decoration: InputDecoration(
                hintText: "Image",
                labelText: "Product Image"
              ),
                validator : (String? value){
                  if(value == null || value!.isEmpty)
                  {
                    return "Enter a valid value";
                  }
                  else
                  {
                    return null;
                  }
                }
            ),
            TextFormField(
              controller: _codeTEController,
              decoration: InputDecoration(
                hintText: "Product Code",
                labelText: "Product Code"
              ),
                validator : (String? value){
                  if(value == null || value!.isEmpty)
                  {
                    return "Enter a valid value";
                  }
                  else
                  {
                    return null;
                  }
                }
            ),
            TextFormField(
              controller: _quantityTEController,
              decoration: InputDecoration(
                hintText: "Quantity ",
                labelText: "Quantity "
              ),
                validator : (String? value){
                  if(value == null || value!.isEmpty)
                  {
                    return "Enter a valid value";
                  }
                  else
                  {
                    return null;
                  }
                }
            ),
            SizedBox(height: 16,),
            _inprogress?Center(child:CircularProgressIndicator()):
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(double.maxFinite)),
              onPressed: _addTapAddProductButton,
              child: const Text("Add Product"),
            ),
          ],
        ),
      );
  }

  void _addTapAddProductButton()
  {
    if(_formKey.currentState!.validate()){
      addNewProduct();

    }

  }

  Future<void> addNewProduct() async {
    _inprogress =true;
    setState(() {
      
    });
    
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/CreateProduct');
    Map<String ,dynamic> requestbody= {
      "Img":_imageTEController.text,
      "ProductCode":_codeTEController.text,
      "ProductName":_productNameTEController.text,
      "Qty":_quantityTEController.text,
      "TotalPrice":_totalPriceTEController.text,
      "UnitPrice":_unitPriceTEController.text,
    };
    Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestbody),
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      _clearTextFields();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New product added')));

    }
    _inprogress =false;
    setState(() {

    });


  }

  void _clearTextFields() {
    _productNameTEController.clear();
    _quantityTEController.clear();
    _totalPriceTEController.clear();
    _unitPriceTEController.clear();
    _imageTEController.clear();
    _codeTEController.clear();
  }

  //dispose
  @override
  void dispose() {
    _productNameTEController.dispose();
    _unitPriceTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    _codeTEController.dispose();
    _quantityTEController.dispose();
    super.dispose();
  }
}

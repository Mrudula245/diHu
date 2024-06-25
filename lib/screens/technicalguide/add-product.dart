import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/category_model.dart';
import 'package:dihub/models/product_model.dart';
import 'package:dihub/screens/technicalguide/view_product.dart';
import 'package:dihub/services/category_service.dart';
import 'package:dihub/services/product_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ProductService _productService = ProductService();
  final CategoryService _categoryService = CategoryService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool uploading = false;
  List<CategoryModel> categoryList = [];
  String? selectedCategory;
  final _formKey = GlobalKey<FormState>();

  var id;

  getData() async {
    id = await FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }

  void _addProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        uploading = true;
      });
      var id = Uuid().v1();
      String title = _titleController.text;
      String description = _descriptionController.text;

      if (_selectedCategory == null) {
        setState(() {
          uploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a category')),
        );
        return;
      }
      print(_selectedCategory);
      ProductModel product = ProductModel(
        uid: id,
        title: title,
        img: '', // Temporary placeholder
        desc: description,
        category: _selectedCategory,
        guideId: id,
        status: 1,
        createdAt: DateTime.now(),
      );

      bool? res = await _productService.addProduct(product, imageurl!);
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        imageurl = null;
        uploading = false;
      });

      if (res == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product')),
        );
      }
    }
  }

  void _navigateToAllCreatedActivitiesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllCreatedProducts(),
      ),
    );
  }

  var filename;
  XFile? imageurl;
  final ImagePicker _picker = ImagePicker();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<CategoryModel> _categories;
  String? _selectedCategory;

  Future<void> _fetchCategories() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('categories').get();
      setState(() {
        _categories = snapshot.docs
            .map((doc) => CategoryModel.fromDocumentSnapshot(doc))
            .toList();
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    print(imageurl.runtimeType);
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Add Product',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _navigateToAllCreatedActivitiesPage,
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showImagePicker();
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blue[100],
                            ),
                            child: imageurl != null
                                ? Image.file(File(imageurl!.path))
                                : Container(
                              color: Colors.white12,
                              child: Icon(
                                Icons.camera_alt,
                                size: 100,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 11,
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            icon: Icon(Icons.arrow_downward,
                                color: Colors.white),
                            iconSize: 24,
                            hint: Text("Select Category",
                                style: TextStyle(color: Colors.white)),
                            elevation: 16,
                            style: TextStyle(color: Colors.blue),
                            dropdownColor: Colors.lightBlueAccent,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedCategory = newValue;
                              });
                            },
                            items: _categories.map<DropdownMenuItem<String>>(
                                    (CategoryModel category) {
                                  return DropdownMenuItem<String>(
                                    value: category.title,
                                    child: Text(
                                      category.title!,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    onPressed: _addProduct,
                    child: Text('Add Product'),
                  ),
                ],
              ),
            ),
          ),
          if (uploading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  imageFromGallery() async {
    final XFile? _image =
    await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageurl = _image;
    });
  }

  imageFromCamera() async {
    final XFile? _image =
    await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageurl = _image;
    });
  }

  showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                imageFromCamera();
              },
            ),
            ListTile(
              title: Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                imageFromGallery();
              },
            ),
          ],
        );
      },
    );
  }
}

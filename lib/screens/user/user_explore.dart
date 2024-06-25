import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/category_model.dart';
import 'package:dihub/models/product_model.dart';
import 'package:dihub/models/user_model.dart';

import 'package:dihub/screens/user/product_details.dart';
import 'package:dihub/services/category_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);@override
  State<ExplorePage> createState() => _ExplorePageState();
}
class _ExplorePageState extends State<ExplorePage> {
  final CategoryService _categoryService = CategoryService();
  TextEditingController _searchController = TextEditingController();
  UserModel? currentUser;
  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }Future<void> _fetchCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();
        setState(() {
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
  int selectedCategoryIndex = 0;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<CategoryModel>> _fetchCategories() async {
    QuerySnapshot snapshot = await _firestore.collection('categories').get();
    return snapshot.docs
        .map((doc) => CategoryModel.fromDocumentSnapshot(doc))
        .toList();
  }
  Future<List<ProductModel>> _fetchActivities(String categoryTitle) async {
    QuerySnapshot snapshot;

    if (categoryTitle == "All Products") {
      snapshot = await _firestore.collection('products').get();
    } else {
      print(categoryTitle);
      snapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: categoryTitle)
          .get();
    }
    return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          iconTheme: IconThemeData(color: Colors.white),
          toolbarHeight: 100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Find your favourite \nProducts",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.cyan,
          //Color(0xffeae2b7),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(height: 5),
                  if (currentUser != null)
                    Text(
                      currentUser!.name ?? 'Guest',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          ),
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Activity...',
                        hintStyle: TextStyle(color: Colors.blue),
                        suffixIcon: Icon(
                          Iconsax.search_normal_1,
                          color: Colors.blue,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                              Colors.blue), // Border color when focused
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(
                              color: Colors.blue.withOpacity(0.8),
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Text("See All",
                                style: TextStyle(
                                    color: Colors.blue.withOpacity(0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<List<CategoryModel>>(
                        future: _fetchCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                                child: Text('No categories available'));
                          }
                          final categoryList = [
                            CategoryModel(
                                title:
                                "All Products"), // Add the "All Activities" category
                            ...snapshot.data!,
                          ];
                          //  final categoryList = snapshot.data!;
                          return Column(
                            children: [
                              // Category List
                              Container(
                                height: 45,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoryList.length,
                                  itemBuilder: (context, index) {
                                    final category = categoryList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCategoryIndex = index;
                                        });
                                      },
                                      child: Card(
                                        color: selectedCategoryIndex == index
                                            ? Colors.blue
                                            : null,
                                        child: Container(
                                          width: 130,
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              category.title!,
                                              style: TextStyle(
                                                color: selectedCategoryIndex ==
                                                    index
                                                    ? Colors.white
                                                    : Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 200,
                                child: FutureBuilder<List<ProductModel>>(
                                  future: _fetchActivities(
                                      categoryList[selectedCategoryIndex]
                                          .title!),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                          Text('Error: ${snapshot.error}'));
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return Center(
                                          child:
                                          Text('No products available'));
                                    }
                                    final productList = snapshot.data!;
                                    return Column(
                                      children:[ Expanded(
                                        child: ListView.builder(

                                          scrollDirection: Axis.horizontal,
                                          itemCount: productList.length,
                                          itemBuilder: (context, index) {
                                            final product = productList[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>ProductDetailsPage(product:product,),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: Stack(
                                                  children: [
                                                    // Activity Image
                                                    Container(
                                                      width: 300,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              product.img!),
                                                        ),
                                                      ),
                                                    ),
                                                    // Activity Details
                                                    Positioned(
                                                      bottom: 0,
                                                      left: 0,
                                                      right: 0,
                                                      child: Container(
                                                        padding: EdgeInsets.all(8),
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  product.title!,
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                    fontSize: 16,
                                                                  ),
                                                                ),
                                                        //
                                                // ),
                                              ]),]
                                            )
                                            )
                                                    )
                                                  ]
                                                )
                                            ));                                        },
                                        ),
                                      ),
                                   ] );
                                  },
                                ),
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ]
            )
        )

    );
  }
}
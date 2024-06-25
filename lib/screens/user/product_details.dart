import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dihub/models/product_model.dart';
import 'package:dihub/models/cart_model.dart';
import 'package:dihub/models/request_model.dart';
import 'package:dihub/services/request_service.dart';
import 'package:uuid/uuid.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  ProductDetailsPage({required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  var id;

  getData() async {
    id = await FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text('Product Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.product.img ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.product.title ?? '',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.product.desc ?? '',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Category: ${widget.product.category}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CartModel>(context, listen: false)
                        .add(widget.product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product added to favorites!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Add to Favorites',
                      style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _requestGuide(context, widget.product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Request Assistance',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Additional widgets can go here
          ],
        ),
      ),
    );
  }

  void _requestGuide(BuildContext context, ProductModel product) async {
    try {
      var reqid = Uuid().v1();

      RequestModel request = RequestModel(
          timestamp: DateTime.now(),
          userId: id,
          guideId: product.guideId,
          id: reqid,
          productId: product.uid,
          reply: "",
          status: 0);

      RequestService requestService = RequestService();
      await requestService.addRequest(request);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Request Assistance'),
            content: Text('Your request for assistance has been sent.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error requesting assistance: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send request. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

import 'package:dihub/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart_model.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(

        backgroundColor: Colors.cyan,
        title: Text('Your Favourites'),
      ),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final product = cart.items[index];
          return Card(
              shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(15),

          ),
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
          colors: [
          Colors.blue.shade900,
          Colors.blue.shade800,
          Colors.blue.shade400,
          ],
          ),
          ),

            // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(product.img!), // Add this line to display the image
              ),
              title: Text(product.title!,style: TextStyle(color: Colors.white),),
              // subtitle: Text('\$${product.price.toString()}'),
              trailing: IconButton(
                icon: Icon(Icons.delete,color: Colors.red,),
                onPressed: () {
                  cart.remove(product);
                },
              ),
            ),
          ) );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a product to the cart (for demonstration purposes)
          final product = ProductModel(
            uid: '1',
            title: 'Sample Product',
            desc: 'This is a sample product',
            img: 'https://via.placeholder.com/150',
            // price: 10.0,
            category: 'Sample Category',
          );
          cart.add(product);
        },
         child: Icon(Icons.add),
      ),
    );
  }
}

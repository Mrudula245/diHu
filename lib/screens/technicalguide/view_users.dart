import 'package:dihub/models/product_model.dart';
import 'package:dihub/models/user_model.dart';
import 'package:dihub/screens/technicalguide/guide_recommentation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/request_model.dart';
import 'package:dihub/services/request_service.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<RequestModel> _requests = [];

  var id;

  getData() async {
    id = await FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
    _fetchRequests();
  }

  Future<void> _fetchRequests() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('requests')
          .where('guideId', isEqualTo: id)
          .get();
      setState(() {
        _requests = querySnapshot.docs
            .map((doc) =>
            RequestModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        print(_requests);
      });
    } catch (error) {
      print('Error fetching request data: $error');
      // Handle error accordingly
    }
  }

  Future<ProductModel> getProductData(String id) async {
    DocumentSnapshot? snap =
    await FirebaseFirestore.instance.collection('products').doc(id).get();

    return ProductModel.fromSnapshot(snap);
  }

  Future<UserModel> getuserData(String id) async {
    print(id);
    DocumentSnapshot? snap =
    await FirebaseFirestore.instance.collection('user').doc(id).get();

    return UserModel.fromJoson(snap);
  }

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text('User List',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.cyan,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.refresh,color: Colors.white,),
        //     onPressed: _fetchRequests,
        //   ),
        //
        // ],
      ),
      body: _buildRequestsList(),
    );
  }

  Widget _buildRequestsList() {
    if (_requests == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_requests.isEmpty) {
      return Center(
        child: Text('No user found.'),
      );
    } else {
      return ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          RequestModel request = _requests[index];
          return FutureBuilder(
              future: getProductData(_requests![index].productId.toString()),
              builder: (context, snapshot) {
                if (_requests == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (_requests.isEmpty) {
                  return Center(
                    child: Text('No user  found.'),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data;
                  return FutureBuilder(
                      future: getuserData(_requests![index].userId.toString()),
                      builder: (context, snapshot) {
                        if (_requests == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (_requests.isEmpty) {
                          return Center(
                            child: Text('No user found.'),
                          );
                        } else if (snapshot.hasData) {
                          final userdata = snapshot.data;

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
                                child: ListTile(
                                  // onTap: (){
                                  //
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(builder: (context) => Recommendation(req: request,)),
                                  //   );
                                  // },
                                  // title: Text("${data!.title.toString()}",style: TextStyle(color: Colors.white),),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${userdata!.name}",style: TextStyle(color: Colors.white),),
                                      SizedBox(height:2 ,),

                                      Text("${userdata!.phone}",style: TextStyle(color: Colors.white),),


                                    ],
                                  ),
                                ),
                              ));
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                }

                return CircularProgressIndicator();
              });
        },
      );
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopp/core/store.dart';
import 'package:e_shopp/models/cart.dart';
import 'package:e_shopp/models/catelog.dart';
import 'package:e_shopp/pages/home_details_page.dart';
import 'package:e_shopp/utils/ressources/dimensions/constants.dart';
import 'package:e_shopp/utils/routes.dart';
import 'package:e_shopp/widgets/home_widgets/catelog_header.dart';
import 'package:e_shopp/widgets/home_widgets/catelog_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  loadData() async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    final catelogJson = await rootBundle.loadString('assets/files/catelog.json');

    // final response = await http.get(Uri.parse(url));
    //final catelogJson = response.body;
    final decodedData = jsonDecode(catelogJson);
    var productsData = decodedData['products'];
    CatelogModel.items = List.from(productsData).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }

  Widget positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget negative() {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "No",
          style: TextStyle(color: Colors.purple),
        ));
  }

  Future<bool> avoidRteurnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Do you want to leave"),
            actions: [
              negative(),
              positive(),
            ],
          );
        });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    // final dummyList = List.generate(20, (index) => CatelogModel.items[0]);
    return WillPopScope(
      onWillPop: avoidRteurnButton,
      child: Scaffold(
        backgroundColor: context.canvasColor,
        floatingActionButton: VxBuilder(
          mutations: {AddMutation, RemoveMutation},
          builder: (context, dynamic store, _) => FloatingActionButton(
            /* onPressed: () async {
              var cnx = FirebaseFirestore.instance.collection('products');
              List data = [
                {
                  'users': [],
                  "name": "Double Tie Shirt",
                  "desc": "White Premium Linen Look Double Tie Shirt",
                  "price": 875,
                  "color": "#7c95eb",
                  "image":
                      "https://cdn-img.prettylittlething.com/1/5/0/f/150fd0010a4c12b2e08117504b0f2cf654e96e18_cni5530_1.jpg?imwidth=1000"
                },
                {
                  'users': [],
                  "name": "Leg Trouser",
                  "desc": "Premium Black Linen Look Wide Leg Trouser",
                  "price": 45,
                  "color": "#7c95eb",
                  "image":
                      "https://cdn-img.prettylittlething.com/d/3/4/c/d34c7062f80e8d1ffdf415192b2c854572a8e054_cni5531_1.jpg?imwidth=1000"
                },
                {
                  'users': [],
                  "name": "Mini Skirt",
                  "desc": "Pink Polka Dot Mini Skirt",
                  "price": 856,
                  "color": "#7c95eb",
                  "image":
                      "https://cdn-img.prettylittlething.com/a/5/8/e/a58e39c04de5e8239f4d85c4858f631d87387a71_cni7987_1.jpg?imwidth=1000"
                },
                {
                  'users': [],
                  "name": "Maxi Dress",
                  "desc": "Black Chiffon Floral Detail Maxi Dress",
                  "price": 874,
                  "color": "#7c95eb",
                  "image":
                      "https://cdn-img.prettylittlething.com/7/9/4/0/794060f107f37527a3a532fa2d0d6e5459ab2c76_cni4355_1.jpg?imwidth=1000"
                }
              ];
              data.map((e) {
                print('ee');
                var doc = cnx.doc();
                cnx.doc(doc.id).set(e);
                cnx.doc(doc.id).update({"id": doc.id});
              }).toList();
            },*/
            onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
            // backgroundColor: context.theme.buttonColor,
            child: Icon(
              CupertinoIcons.cart,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatelogHeader(),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("products").snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Item> data = [];
                            var fireBaseData = snapshot.data!.docs.toList();
                            for (var line in fireBaseData) {
                              data.add(Item.fromMap(line.data() as Map<String, dynamic>));
                            }
                            // use listview builder to display data from data source dynamicly
                            if (data.isEmpty) {
                              return Center(
                                child: Text("no data"),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Constants.screenHeight * 0.02, horizontal: Constants.screenWidth * 0.03),
                                child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Details(
                                              catelog: data[index],
                                            ),
                                          ),
                                        ),
                                        child: CatelogItem(catelog: data[index]),
                                      );
                                    }),
                              );
                            }
                          } else {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.purple,
                            ));
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

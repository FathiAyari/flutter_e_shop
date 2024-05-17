import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopp/models/catelog.dart';
import 'package:e_shopp/pages/home_details_page.dart';
import 'package:e_shopp/utils/ressources/dimensions/constants.dart';
import 'package:e_shopp/widgets/home_widgets/catelog_list.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  var user = GetStorage().read('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: 'Cart'.text.color(context.accentColor).make(),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: context.canvasColor,
      body: Column(
        children: [
          Text(
            'Cart',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textScaleFactor: 2,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection("products").where("users", arrayContains: user['uid']).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Item> data = [];
                      var fireBaseData = snapshot.data!.docs.toList();
                      for (var line in fireBaseData) {
                        data.add(Item.fromMap(line.data() as Map<String, dynamic>));
                      }
                      if (data.isEmpty) {
                        return Center(
                          child: Text("no products in your card"),
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
    );
  }
}

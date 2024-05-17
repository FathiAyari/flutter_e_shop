import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shopp/models/cart.dart';
import 'package:e_shopp/models/catelog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCart extends StatefulWidget {
  final bool isCehcked;
  final Item? catelog;
  AddToCart({Key? key, this.catelog, required this.isCehcked}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  var user = GetStorage().read("user");
  bool check = false;

  @override
  Widget build(BuildContext context) {
    List oldData = widget.catelog!.users;
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    return ElevatedButton(
      onPressed: () {
        if (oldData.contains(user['uid'])) {
          setState(() {
            oldData.remove(user['uid']);
          });
        } else {
          setState(() {
            oldData.add(user['uid']);
          });
        }
        FirebaseFirestore.instance.collection("products").doc(widget.catelog!.id).update({"users": oldData});
      },
      child: widget.catelog!.users.contains(user['uid']) ? Icon(Icons.done) : Icon(CupertinoIcons.cart_badge_plus),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
        StadiumBorder(),
      )),
    );
  }
}

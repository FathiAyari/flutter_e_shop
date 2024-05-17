import 'package:e_shopp/models/snack_bar_types.dart';
import 'package:e_shopp/utils/ressources/dimensions/constants.dart';
import 'package:flutter/material.dart';

class SnackBars {
  final BuildContext context;
  final SnackBarsTypes type;
  final String label;
  final VoidCallback onTap;
  final String actionLabel;

  SnackBars({required this.context, required this.type, required this.label, required this.onTap, required this.actionLabel});
  Color getRightColor(SnackBarsTypes type) {
    if (type == SnackBarsTypes.alert) {
      return Colors.red;
    } else if (type == SnackBarsTypes.information) {
      return Colors.purple;
    } else
      return Colors.green;
  }

  void showSnackBar() {
    final snackBar = SnackBar(
      backgroundColor: getRightColor(type),
      margin: EdgeInsets.all(1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: '${this.actionLabel}',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          onTap();
        },
      ),
      content: Container(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.015),
                child: Text("${this.label}"),
              ),
            )
          ],
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

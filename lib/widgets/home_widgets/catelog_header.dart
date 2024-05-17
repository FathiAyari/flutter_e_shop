import 'package:e_shopp/services/AuthServices.dart';
import 'package:flutter/material.dart';

class CatelogHeader extends StatefulWidget {
  @override
  _CatelogHeaderState createState() => _CatelogHeaderState();
}

class _CatelogHeaderState extends State<CatelogHeader> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'E - Shop',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // color: context.theme.accentColor,
              ),
              textScaleFactor: 3,
            ),
            IconButton(
                onPressed: () {
                  AuthServices().logOut(context);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.red,
                ))
          ],
        ),
        Text(
          'Trending products',
          style: TextStyle(
              // color: context.theme.accentColor,
              ),
          textScaleFactor: 1.5,
        ),
      ],
    );
  }
}

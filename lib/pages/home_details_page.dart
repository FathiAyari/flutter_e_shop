import 'package:e_shopp/models/catelog.dart';
import 'package:e_shopp/widgets/home_widgets/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Details extends StatelessWidget {
  final Item catelog;

  const Details({Key? key, required this.catelog})
      : assert(catelog != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: context.canvasColor,
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: SafeArea(
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            buttonPadding: EdgeInsets.zero,
            children: [
              '\$${catelog.price}'.text.bold.xl4.red500.make(),
              AddToCart(
                isCehcked: true,
                catelog: catelog,
              ).wh(150, 50)
            ],
          ).p20(),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(catelog.id.toString()),
              child: Image.network(catelog.image!),
            ).h32(context),
            Expanded(
              child: VxArc(
                height: 20.0,
                arcType: VxArcType.convey,
                edge: VxEdge.top,
                child: Container(
                  padding: EdgeInsets.only(top: 40),
                  color: context.cardColor,
                  width: context.screenWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        catelog.name!.text.xl4.color(context.accentColor).bold.make(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: catelog.desc!.text.textStyle(context.captionStyle!).lg.make(),
                        ),
                        10.heightBox,
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:e_shopp/pages/cart_page.dart';
import 'package:e_shopp/pages/login_page.dart';
import 'package:e_shopp/utils/routes.dart';
import 'package:e_shopp/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'core/store.dart';
import 'pages/home_page.dart';

void main() {
  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
           theme: Mytheme.lightTheme(context),
            darkTheme: Mytheme.darkTheme(context),
            initialRoute: "/",
            routes: {
              "/": (context) => LoginPage(),
              MyRoutes.homeRoute: (context) => HomePage(),
              MyRoutes.loginRoute: (context) => LoginPage(),
              MyRoutes.cartRoute: (context) => CartPage(),
            },
          );
        });
  }
}

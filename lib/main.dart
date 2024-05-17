import 'package:e_shopp/pages/cart_page.dart';
import 'package:e_shopp/pages/login_page.dart';
import 'package:e_shopp/pages/splash_screen.dart';
import 'package:e_shopp/utils/routes.dart';
import 'package:e_shopp/widgets/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'core/store.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // initialize firebase app
  await GetStorage.init(); // initialize getStorage
  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: Mytheme.lightTheme(context),
            darkTheme: Mytheme.darkTheme(context),
            initialRoute: "/",
            routes: {
              "/": (context) => SplashScreen(),
              MyRoutes.homeRoute: (context) => HomePage(),
              MyRoutes.loginRoute: (context) => LoginPage(),
              MyRoutes.cartRoute: (context) => CartPage(),
            },
          );
        });
  }
}

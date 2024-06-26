import 'package:e_shopp/pages/register.dart';
import 'package:e_shopp/pages/snack_bar.dart';
import 'package:e_shopp/services/AuthServices.dart';
import 'package:flutter/material.dart';

import '../models/snack_bar_types.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Image.asset(
                "assets/images/login_image.png",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(filled: true, labelText: 'Email', fillColor: Colors.purple.withOpacity(0.2)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email cannot be null";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          filled: true,
                          fillColor: Colors.purple.withOpacity(0.1),
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be null";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    changeButton
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          )
                        : Material(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(8.0),
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    changeButton = true;
                                  });
                                  AuthServices().signIn(email.text, password.text).then((value) async {
                                    if (value) {
                                      AuthServices().getUserData().then((value) {
                                        AuthServices().saveUserLocally(value).then((value2) {
                                          Navigator.pushNamed(context, "/home");
                                        });
                                      });
                                    } else {
                                      SnackBars(
                                              label: "Check email and password",
                                              type: SnackBarsTypes.alert,
                                              onTap: () {},
                                              actionLabel: "Close",
                                              context: context)
                                          .showSnackBar();
                                      setState(() {
                                        changeButton = false;
                                      });
                                    }
                                  });
                                }
                              },
                              child: Container(
                                width: 150.0,
                                height: 50.0,
                                alignment: Alignment.center,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register()));
                          },
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              text: "You don't have an account ? \n", // Display text excluding clickableText
                              children: [
                                TextSpan(
                                  text: "Create account",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ) /*Row(
                          children: [
                            Text("You don't have an account ?"),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      "Create account",
                                      style: TextStyle(color: Colors.purple),
                                    )),
                              ),
                            )
                          ],
                        )*/
                        ,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

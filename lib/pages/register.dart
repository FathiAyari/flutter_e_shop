import 'package:e_shopp/models/snack_bar_types.dart';
import 'package:e_shopp/pages/snack_bar.dart';
import 'package:e_shopp/services/AuthServices.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  setData() {
    setState(() {
      email.text = "tet@gmail.com";
      password.text = "testtest";
      name.text = "tet@gmail.com";
      lastName.text = "tet@gmail.com";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Regitser',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: name,
                        decoration: InputDecoration(filled: true, labelText: 'Name', fillColor: Colors.purple.withOpacity(0.2)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "name cannot be null";
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
                        controller: lastName,
                        decoration:
                            InputDecoration(filled: true, labelText: 'Last Name', fillColor: Colors.purple.withOpacity(0.2)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "last name cannot be null";
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
                        controller: email,
                        decoration: InputDecoration(filled: true, labelText: 'Email', fillColor: Colors.purple.withOpacity(0.2)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email cannot be null";
                          }
                          bool emailValid =
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                          if (!emailValid) {
                            return "invalide email format";
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
                            return "Password length must be more thans 6";
                          }
                          if (value.length < 6) {
                            return "Password length must be more thans 6";
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

                                  AuthServices()
                                      .signUp(
                                          email: email.text, password: password.text, name: name.text, lastName: lastName.text)
                                      .then((value) async {
                                    if (value) {
                                      AuthServices().getUserData().then((value) {
                                        AuthServices().saveUserLocally(value).then((value2) {
                                          Navigator.pushNamed(context, "/home");
                                        });
                                      });
                                    } else {
                                      SnackBars(
                                              label: "Check email and password or the email is alreeady used",
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

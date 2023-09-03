import 'package:flutter/material.dart';

import 'package:project/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signUppage extends StatefulWidget {
  State<signUppage> createState() {
    return signUppageState();
  }
}

class signUppageState extends State<signUppage> {
  bool login = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = '';
  String password = '';
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;
  void signup() async {
    final formState = formkey.currentState!.save();
    print('Form saved');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final db = FirebaseFirestore.instance;

      final user = {
        'email': email,
        'password': password,
        'posts': [],
        'todo': {},
      };

      db
          .collection("users")
          .doc(credential.user?.uid)
          .set(user)
          .onError((e, _) => print("Error writing document: $e"));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homepage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

      SnackBar snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  signin() async {
    try {
      final formState = formkey.currentState!.save();
      print(email);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homepage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      SnackBar snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Email/Pass Auth")),
        ),
        body: Form(
          key: formkey,
          child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.grey[350],
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 90),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: !login
                            ? Text("Sign Up ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25))
                            : Text("Login ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25))),
                    const SizedBox(
                      height: 45,
                    ),
                    TextFormField(
                      //key: ValueKey('email'),
                      controller: emailController,
                      decoration: InputDecoration(hintText: " Enter Email"),
                      validator: (value) {
                        if (!value.toString().trim().contains('@'))
                          return "invalid Email";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: true,
                      // key: ValueKey('password'),
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: " Enter Password",
                      ),
                      validator: (value) {
                        if (value.toString().trim().length < 6)
                          return "Password too small";
                        else
                          return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                        width: 100,
                        child: (isLoading)
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    login ? signin() : signup();
                                  }
                                },
                                child:
                                    !login ? Text("Sign Up") : Text("Login"))),
                    const SizedBox(
                      height: 35,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          login = !login;
                        });
                      },
                      child: !login
                          ? const Text("Already Have an Account? Log in",
                              style: TextStyle(color: Colors.black))
                          : const Text("Dont Have an Account?sign up ",
                              style: TextStyle(color: Colors.black)),
                    )
                  ],
                ),
              )),
        ));
  }
}

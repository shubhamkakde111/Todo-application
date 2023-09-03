/*import 'package:flutter/material.dart';
import 'package:project/pages/authpage.dart';
import 'package:project/pages/signup.dart';

class loginpage extends StatefulWidget {
  State<loginpage> createState() {
    return loginpageState();
  }
}

class loginpageState extends State<loginpage> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 169, 84, 184),
                  Color.fromARGB(255, 83, 138, 183)
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(55),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.white),
                  width: 330,
                  height: 430,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login Page",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      SizedBox(
                        height: 50,
                      ),
                      Text("Username ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: 220,
                          height: 35,
                          child: TextField(
                            controller: user,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1)),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Password ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: 220,
                          height: 35,
                          child: TextField(
                            controller: pass,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1)),
                            ),
                          )),
                      SizedBox(
                        height: 45,
                      ),
                      ElevatedButton(
                        child: Text('Login'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => authpage()));
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont have an account ?"),
                          InkWell(
                            child: Text(
                              "Sign Up",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => signUppage()));
                            },
                          )
                        ],
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
*/
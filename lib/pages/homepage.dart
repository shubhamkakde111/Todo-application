import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/pages/newtodo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/pages/updateTodo.dart';

class homepage extends StatefulWidget {
  State<homepage> createState() => homepagestate();
}

class homepagestate extends State<homepage> {
  void delete(String pid) async {
    CollectionReference todo =
        await FirebaseFirestore.instance.collection('todo');
    todo.doc(pid).delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
          child: Text(
            "Task Deleted Successfully! ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
      ));
    }).catchError((error) => print("Failed to delete user: $error"));
  }

  void Update(String pid) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => updateTodo(pid)));
  }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('todo')
      .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment(0, 1), child: Text("HomePage")),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
                    child: Center(
                        child: Text(
              "Loading ....",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ))));
          }

          return Stack(children: [
            Container(
              height: double.infinity,
              color: Color.fromARGB(255, 228, 220, 220),
            ),
            ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(bottom: 50, top: 5),
                      color: const Color.fromARGB(255, 228, 220, 220),
                      child: Column(
                        children: [
                          Container(
                            child: Container(
                              height: 40,
                              color: Colors.grey[600],
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(""),
                                    Container(
                                        child: Text(
                                      data['title'].toString().toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Container(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              child: Icon(Icons.delete,
                                                  color: Colors.white),
                                              onTap: () {
                                                delete(data['pid']);
                                              },
                                            ),
                                            InkWell(
                                              child: Icon(Icons.update,
                                                  color: Colors.white),
                                              onTap: () {
                                                Update(data['pid']);
                                              },
                                            )
                                          ],
                                        )),
                                  ]),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(10),
                              height: 60,
                              width: double.maxFinite,
                              color: Colors.grey[400],
                              child: Text(
                                data['description'],
                                style: TextStyle(fontSize: 17),
                              ))
                        ],
                      )),
                );
              }).toList(),
            ),
            Align(
              alignment: Alignment(0.8, 0.99),
              child: InkWell(
                child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(23)),
                    child: Icon(Icons.add)),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Todo()));
                },
              ),
            ),
          ]);
        },
      ),
    );
  }
}

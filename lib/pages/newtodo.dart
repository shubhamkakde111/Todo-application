import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/resource/todo.dart';

class Todo extends StatefulWidget {
  State<Todo> createState() {
    return TodoState();
  }
}

class TodoState extends State<Todo> {
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String title = '';
  String description = '';
  Future addNew() async {
    final cuser = FirebaseAuth.instance.currentUser;
    final cid = cuser?.uid;
    final item = todoItem(title: title, description: description);

    final db =
        await FirebaseFirestore.instance.collection("todo").doc(item.id).set({
      "title": item.title,
      "description": item.description,
      "id": cid,
      "pid": item.id,
    });
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(
        child: Text(
          "Successfully Added New Task ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
    ));
    Navigator.pop(context);

    /*final data = await FirebaseFirestore.instance
        .collection("todo")
        .where("id", isEqualTo: cid)
        .get()
        .then((value) {
      print("data successfully fetched");

      for (var it in value.docs) {
        print("${it.id}: ${it.data()["title"]}");
      }
    }).catchError((error) => print("unable to fetch data: $error"));*/
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formkey,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
                child: Text("ADD NEW TASK ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25))),
            const SizedBox(
              height: 45,
            ),
            TextFormField(
              //key: ValueKey('email'),
              controller: titleController,
              decoration: const InputDecoration(hintText: "Enter Title"),
              validator: (value) {
                if (value.toString().trim().length == 0)
                  return "invalid Title";
                else
                  return null;
              },
              onSaved: (value) {
                title = value!;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              //obscureText: true,
              // key: ValueKey('password'),
              controller: descController,
              decoration: const InputDecoration(hintText: "Description"),

              onSaved: (value) {
                description = value!;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
                width: 100,
                child: (isLoading)
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            setState(() {
                              isLoading = true;
                            });
                            addNew();
                          }
                        },
                        child: const Text("ADD"))),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    ));
  }
}

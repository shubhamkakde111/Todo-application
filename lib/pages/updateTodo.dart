import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/resource/todo.dart';

class updateTodo extends StatefulWidget {
  String pid = "";
  updateTodo(this.pid);
  State<updateTodo> createState() {
    return updateTodoState(pid);
  }
}

class updateTodoState extends State<updateTodo> {
  String Pid = "";

  updateTodoState(this.Pid);
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String title = '';
  String description = '';
  void updation(String pid) async {
    CollectionReference todo =
        await FirebaseFirestore.instance.collection('todo');
    todo.doc(pid).update({
      'title': title,
      'description': description,
    }).then((value) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
          child: Text(
            "Task Details Updated",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
      ));

      Navigator.pop(context);
    }).catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formkey,
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
                child: Text("UPDATE TASK DETAILS",
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
              decoration: InputDecoration(hintText: "Enter Title"),
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
              // key: ValueKey('password'),
              controller: descController,
              decoration: InputDecoration(hintText: "Description"),

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
                            updation(Pid);
                          }
                        },
                        child: Text("UPDATE"))),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    ));
  }
}

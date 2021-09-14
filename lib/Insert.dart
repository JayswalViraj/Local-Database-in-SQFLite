import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqfliteinflutter/dbhelper.dart';

class Insert extends StatefulWidget {
  const Insert({Key? key}) : super(key: key);

  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  @override
  Widget build(BuildContext context) {
    // INPUT FIELD CONTROLLER
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final mobileController = TextEditingController();

    final _formkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Data"),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter Name";
                }
              },
              decoration: InputDecoration(
                hintText: "Enter Name",
                labelText: "Name",
              ),
            ),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter E-Mail";
                } else if (!value.contains('@')) {
                  return "Please Enter Valid E-Mail";
                }
              },
              decoration: InputDecoration(
                hintText: "Enter E-Mail",
                labelText: "E-Mail",
              ),
            ),
            TextFormField(
              maxLength: 10,
              controller: mobileController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter Mobile No";
                }
                if (value.length < 10) {
                  return "Please Enter Valid Mobile No";
                }
              },
              decoration: InputDecoration(
                hintText: "Enter Mobile No",
                labelText: "Mobile No",
              ),
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    await DatabaseHelper.instance.add(
                      Grocery(
                          name: nameController.text,
                          mob: mobileController.text,
                          email: emailController.text),
                    );
                    setState(() {
                      nameController.clear();
                      mobileController.clear();
                      emailController.clear();
                    });

                    print("inserted Data");

                    await Navigator.pushNamed(context, "readdata");
                  }
                },
                child: Text("SAVE"))
          ],
        ),
      ),
    );
  }
}

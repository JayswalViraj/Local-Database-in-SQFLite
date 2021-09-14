import 'package:flutter/material.dart';

import 'package:sqfliteinflutter/dbhelper.dart';

class ReadData extends StatefulWidget {
  const ReadData({Key? key}) : super(key: key);

  @override
  _ReadDataState createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  int? selectedId;

  final _formkeyedit = GlobalKey<FormState>();

  final editnameController = TextEditingController();
  final editemailController = TextEditingController();
  final editmobController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Read, Update, Delete Operation"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkeyedit,
            child: Column(
              children: [
                FutureBuilder<List<User>>(
                    future: DatabaseHelper.instance.getUserdata(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<User>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text('Loading...'));
                      }
                      return snapshot.data!.isEmpty
                          ? Center(child: Text('No Data in List.'))
                          : ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: snapshot.data!.map((grocery) {
                                return Center(
                                  child: ListTile(
                                    title: Text(grocery.name),
                                    leading: Text(grocery.mob),
                                    subtitle: Text(grocery.email),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          DatabaseHelper.instance
                                              .remove(grocery.id!);
                                        });
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                    onTap: () {
                                      setState(() {



                                        editnameController.text = grocery.name;
                                        editemailController.text = grocery.email;
                                        editmobController.text = grocery.mob;
                                        selectedId = grocery.id;
                                      });
                                    },
                                    onLongPress: () {},
                                  ),
                                );
                              }).toList(),
                            );
                    }),
                TextFormField(

                  controller: editnameController,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Name";
                    }
                  },
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextFormField(
                  controller: editemailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter E-Mail";
                    } else if (!value.contains('@')) {
                      return "Please Enter Valid E-Mail";
                    }
                  },


                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextFormField(
                  controller: editmobController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Mobile No";
                    }
                    if (value.length < 10) {
                      return "Please Enter Valid Number";
                    }
                  },
                  decoration: InputDecoration(labelText: "Mobile"),
                ),

                SizedBox(width: 10,height: 10,),
                ElevatedButton(

                  onPressed: () async {

                  if(_formkeyedit.currentState!.validate()) {
                    selectedId != null
                        ? await DatabaseHelper.instance.update(
                      User(id: selectedId,
                          name: editnameController.text,
                          email: editemailController.text,
                          mob: editmobController.text),
                    )
                        : await DatabaseHelper.instance.add(
                      User(name: editnameController.text,
                          email: editemailController.text,
                          mob: editmobController.text),
                    );
                    setState(() {
                      editmobController.clear();
                      editemailController.clear();
                      editnameController.clear();
                      selectedId = null;
                    });
                  }

                  },
                      child: Text("EDIT"),
                  ),

              ],
            ),
          ),
        ));
  }
}

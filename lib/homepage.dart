import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongodb/MongoDBModel.dart';

import 'dbHelper/mongodb.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  var firstnameController = new TextEditingController();
  var lastnameController = new TextEditingController();
  var emailController = new TextEditingController();
  var numberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                'Detail Page',
                style: TextStyle(fontSize: 35),
              ),
              TextField(
                controller: firstnameController,
                decoration: InputDecoration(
                  label: Text('First Name'),
                ),
              ),
              TextField(
                controller: lastnameController,
                decoration: InputDecoration(
                  label: Text('Last Name'),
                ),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  label: Text('Email'),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: numberController,
                decoration: InputDecoration(
                  label: Text('Number'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _insertData(
                        firstnameController.text,
                        lastnameController.text,
                        emailController.text,
                        numberController.text,
                        context);
                  },
                  child: Text('Add'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _insertData(String fname, String lname, String email, String num,
      BuildContext context) async {
    var id = M.ObjectId();
    final data = MongoDbModel(
      id: id,
      firstname: fname,
      lastname: lname,
      email: email,
      number: num,
    );
    var result = await MangoDatabaseHelper.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Added : ' + id.$oid)));
    firstnameController.clear();
    lastnameController.clear();
    emailController.clear();
    numberController.clear();
  }
}

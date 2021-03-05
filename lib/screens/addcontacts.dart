import 'package:contacts/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';

class AddContacts extends HookWidget {
  final _textFormFielName = TextEditingController();
  final _textFormFielPhoneNumber = TextEditingController();
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyPhoneNumber = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Contact'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
            splashRadius: 24,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                if (_formKeyName.currentState!.validate() &
                    _formKeyPhoneNumber.currentState!.validate()) {
                  print(_textFormFielName.text.toString() +
                      ' ' +
                      _textFormFielPhoneNumber.text.toString());
                  final contactNew = Contact(_textFormFielName.text.toString(),
                      _textFormFielPhoneNumber.text.toString());
                  final contactsBox = Hive.box('contacts');
                  contactsBox
                      .add(contactNew)
                      .then((value) => Navigator.pop(context));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Contact Saved.')));
                }
              },
              splashRadius: 24,
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              //EditText Name
              Container(
                padding: EdgeInsets.all(24.0),
                child: Form(
                  key: _formKeyName,
                  child: TextFormField(
                    controller: _textFormFielName,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Name can\'t be empty.';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      errorStyle: TextStyle(height: 1),
                      border: UnderlineInputBorder(),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
              //EditText Phone Number
              Container(
                padding: EdgeInsets.all(24.0),
                child: Form(
                  key: _formKeyPhoneNumber,
                  child: TextFormField(
                    controller: _textFormFielPhoneNumber,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Contact number can\'t be empty.';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Contact Number',
                        border: UnderlineInputBorder()),
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

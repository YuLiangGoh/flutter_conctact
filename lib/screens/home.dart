import 'package:contacts/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';

class Home extends HookWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hive.openBox('contacts');
    // final contactsBox = Hive.box('contacts');
    // contactsBox.watch().listen((event) {});

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box('contacts').listenable(),
          builder: (context, Box<dynamic> box, widget) {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final contact = box.get(index) as Contact;
                return Container(
                  padding: EdgeInsets.all(4.0),
                  child: Card(
                    child: InkWell(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(contact.name[0]),
                        ),
                        title: Text(contact.name),
                        subtitle: Text(contact.phoneNo),
                      ),
                      onTap: () {},
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/AddContact');
          },
        ),
      ),
    );
  }
}

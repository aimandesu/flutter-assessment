import 'package:flutter/material.dart';
import 'package:flutter_assessment/provider/contact_data.dart';
import 'package:flutter_assessment/widgets/contact_layout.dart';
import 'package:provider/provider.dart';
import '../../model/contact.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.onScroll});

  final ScrollController onScroll;

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactData>(context).contactList();

    return FutureBuilder(
      future: contactProvider,
      builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
            child: Image.asset("assets/empty.jpg"),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
            controller: onScroll,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final contact = snapshot.data![index];
              return ContactLayout(contact: contact);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/db.dart';
import '../../model/contact.dart';
import '../../provider/contact_data.dart';
import '../../widgets/contact_layout.dart';

class Search extends StatelessWidget {
  const Search({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final contactProvider =
        Provider.of<ContactData>(context).searchContact(query);

    return FutureBuilder(
      future: contactProvider,
      builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "No Contact Found",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
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

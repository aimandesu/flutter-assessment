import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/contact.dart';
import '../../provider/contact_data.dart';
import '../../widgets/contact_layout.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactData>(context).favContactList();

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FutureBuilder(
      future: contactProvider,
      builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return isPortrait
              ? Column(
                  children: [
                    const SizedBox(height: 30),
                    Image.asset("assets/empty.jpg"),
                    const Text("No list of contact here,\n   add contact now")
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/empty.jpg"),
                    const Text("No list of contact here,\n   add contact now")
                  ],
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

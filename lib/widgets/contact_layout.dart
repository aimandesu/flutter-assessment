import 'package:flutter/material.dart';
import 'package:flutter_assessment/widgets/tile_slider.dart';

import '../model/contact.dart';
import '../screen/profile/profile.dart';

class ContactLayout extends StatelessWidget {
  const ContactLayout({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return TileSlider(
      widget: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(contact.avatar),
        ),
        title: Row(
          //here makes it according if it's 1 which means that it is fav
          children: [
            Text(contact.first_name),
            contact.favourite == 0
                ? Container()
                : const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
          ],
        ),
        subtitle: Text(contact.email),
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              Profile.routeName,
              arguments: {"contact": contact, "from": "contact_layout"},
            );
          },
          icon: const Icon(
            Icons.send,
            color: Color(0xFF32BAA5),
          ),
        ),
      ),
      contact: contact,
    );
  }
}

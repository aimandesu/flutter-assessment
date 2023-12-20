import 'package:flutter/material.dart';
import 'package:flutter_assessment/screen/profile/widgets/submit_button.dart';

import '../../../model/contact.dart';

class EditFields extends StatelessWidget {
  const EditFields({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
  });

  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final Contact updatedContact = Contact(
      id: contact.id,
      email: email.text,
      first_name: firstName.text,
      last_name: lastName.text,
      avatar: contact.avatar,
      favourite: contact.favourite,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        definedInput("First Name", context, firstName, TextInputType.text),
        definedInput("Last Name", context, lastName, TextInputType.text),
        definedInput("Email", context, email, TextInputType.text),
        SubmitButton(
          hint: "Done",
          contact: updatedContact,
        )
      ],
    );
  }

  Column definedInput(
    String hintText,
    BuildContext context,
    TextEditingController textEditingController,
    TextInputType textInputType,
  ) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 20),
            child: Align(alignment: Alignment.topLeft, child: Text(hintText))),
        Container(
          padding: const EdgeInsets.all(10),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: TextField(
            enableInteractiveSelection: false,
            controller: textEditingController,
            keyboardType: textInputType,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration.collapsed(
              hintText: '',
            ),
          ),
        ),
      ],
    );
  }
}

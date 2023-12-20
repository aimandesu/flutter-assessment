import 'package:flutter/material.dart';
import 'package:flutter_assessment/constant.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/contact.dart';
import '../../../provider/contact_data.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.hint, this.contact});

  final String hint;
  final Contact? contact;

  void launchEmailSubmission(String email) async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: email,
        // query: 'subject=Default Subject&body=Default body'
    );
    String url = params.toString();
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactData>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (hint == "Done") {
          contactProvider.updateContact(contact!);
          Navigator.of(context).pop();
        } else {
          launchEmailSubmission(contact!.email);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: size.width * 0.9,
        height: 60,
        decoration: decorationCircular(Theme.of(context).primaryColor, 35),
        child: Center(
          child: Text(hint),
        ),
      ),
    );
  }
}

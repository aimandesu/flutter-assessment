import 'package:flutter/material.dart';
import 'package:flutter_assessment/model/contact.dart';
import 'package:flutter_assessment/screen/profile/edit_profile/edit_fields.dart';
import 'package:flutter_assessment/screen/profile/widgets/email.dart';
import 'package:flutter_assessment/screen/profile/widgets/picture_name.dart';
import 'package:flutter_assessment/screen/profile/widgets/submit_button.dart';
import 'package:provider/provider.dart';

import '../../provider/contact_data.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";

  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool editProfile = false;
  bool _isInit = true;
  late Map<String, dynamic> args;

  //text editing controller
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();

  void changeEditProfile() {
    setState(() {
      editProfile = true;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final Contact details = args["contact"] as Contact;
      final String from = args["from"];

      //set details
      firstName.text = details.first_name;
      lastName.text = details.last_name;
      email.text = details.email;

      if (from == "tile_slider") {
        changeEditProfile();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final contactProvider = Provider.of<ContactData>(context, listen: false);

    void markFavourite() async {
      int curFav = args["contact"].favourite;
      int change = curFav == 0 ? 1 : 0;
      args["contact"].favourite = change;
      await contactProvider.updateContact(args["contact"]);
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            PictureName(
              editProfile: editProfile,
              name:
                  "${args["contact"].first_name} ${args["contact"].last_name}",
              imgUrl: args["contact"].avatar,
              favourite: args["contact"].favourite,
              id: args["contact"].id,
              changeEditProfile: changeEditProfile,
              markFavourite: markFavourite,
            ),
            editProfile
                ? SizedBox(
                    height: 400,
                    width: size.width * 0.9,
                    child: EditFields(
                      firstName: firstName,
                      lastName: lastName,
                      email: email,
                      contact: args["contact"],
                    ),
                  )
                : Column(
                    children: [
                      Email(email: args["contact"].email),
                      SubmitButton(
                        hint: "Send Email",
                        contact: args["contact"],
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

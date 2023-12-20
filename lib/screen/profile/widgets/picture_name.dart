import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../provider/contact_data.dart';

class PictureName extends StatelessWidget {
  const PictureName({
    super.key,
    required this.editProfile,
    required this.name,
    required this.imgUrl,
    required this.favourite,
    required this.id,
    required this.changeEditProfile,
    required this.markFavourite,
    // required this.toEdit,
  });

  final bool editProfile;
  final String name;
  final String imgUrl;
  final int favourite;
  final int id;
  final VoidCallback changeEditProfile;
  final VoidCallback markFavourite;

  // final Map<String, dynamic> toEdit;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final contactProvider = Provider.of<ContactData>(context, listen: true);

    return SizedBox(
      height: 250,
      width: size.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          editProfile
              ? Align(
            alignment: Alignment.topRight,
                child: SizedBox(
                    height: 50,
                    child: IconButton(
                      onPressed: () async {
                        bool didUserClickYes = await popDialog(context, id);
                        if (didUserClickYes) {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ),
              )
              : SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: markFavourite,
                        icon: favourite == 0
                            ? const Icon(Icons.star_border)
                            : const Icon(Icons.star),
                      ),
                      TextButton(
                        onPressed: changeEditProfile,
                        child: const Text("Edit"),
                      ),
                    ],
                  ),
                ),
          CircleAvatar(
            radius: 70,
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8), // Border radius
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  ClipOval(
                    child: Image.network(imgUrl),
                  ),
                  editProfile
                      ? Positioned(
                          height: 20,
                          width: 20,
                          right: 10,
                          bottom: 0,
                          child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Icon(Icons.check)),
                        )
                      : favourite == 0
                          ? Container()
                          : const Positioned(
                              height: 20,
                              width: 20,
                              right: 10,
                              bottom: 10,
                              child: Icon(Icons.star),
                            ),
                ],
              ),
            ),
          ),
          Text(name),
        ],
      ),
    );
  }
}

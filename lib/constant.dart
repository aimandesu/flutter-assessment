import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_assessment/provider/contact_data.dart';
import 'package:provider/provider.dart';

Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

Decoration decorationCircular(Color color, double circular) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(circular),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 2,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
  );
}

Future<bool> popDialog(
  BuildContext context,
  dynamic value,
) async {
  final contactProvider = Provider.of<ContactData>(context, listen: false);
  bool userClickedYes = false;

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure you want to delete this contact?'),
        actions: <Widget>[
          const Divider(),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    await contactProvider.deleteContact(value);
                    if (context.mounted) {
                      userClickedYes = true;
                      Navigator.of(context).pop();
                    }
                  },
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                TextButton(
                  child: const Text(
                    'No',
                    style: TextStyle(color: Color(0xFF32BAA5)),
                  ),
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      );
    },
  );

  return userClickedYes;
}

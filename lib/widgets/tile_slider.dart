import 'package:flutter/material.dart';
import 'package:flutter_assessment/constant.dart';
import 'package:flutter_assessment/screen/profile/profile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/contact.dart';

class TileSlider extends StatelessWidget {
  const TileSlider({super.key, required this.widget, required this.contact});

  final Widget widget;
  final Contact contact;

  @override
  Widget build(BuildContext context) {

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const DrawerMotion(),
        children: [
           SlidableAction(
            onPressed: (_){
              Navigator.of(context).pushNamed(
                Profile.routeName,
                arguments: {
                  "contact": contact,
                  "from": "tile_slider"
                },
              ).then((value) {
                print(value);
              });
            },
            backgroundColor: const Color(0xFFEBF8F6),
            foregroundColor: Colors.yellow,
            icon: Icons.update,
            label: '',
          ),
          SlidableAction(
            onPressed: (_)  =>  popDialog(context, contact.id),
            backgroundColor: const Color(0xFFEBF8F6),
            foregroundColor: Colors.red,
            icon: Icons.delete,
            label: '',
          ),
        ],
      ),
      child: widget,
    );
  }
}

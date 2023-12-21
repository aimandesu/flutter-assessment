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
      key: ValueKey(contact.id),
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const DrawerMotion(),
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Profile.routeName,
                  arguments: {"contact": contact, "from": "tile_slider"},
                );
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(2),
                width: 20, // space for actionPan
                decoration: BoxDecoration(
                    color: const Color(0xFFEBF8F6),
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(
                  Icons.update,
                  color: Colors.yellow,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                popDialog(context, contact.id);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(2),
                width: 20, // space for actionPan
                decoration: BoxDecoration(
                    color: const Color(0xFFEBF8F6),
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
      child: widget,
    );
  }
}

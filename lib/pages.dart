import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_assessment/constant.dart';
import 'package:flutter_assessment/provider/contact_data.dart';
import 'package:flutter_assessment/screen/favourite/favourite.dart';
import 'package:flutter_assessment/screen/home/home.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = true;
  final pageController = PageController();
  int indexPage = 0;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    bool? isFabVisible;
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      isFabVisible = false;
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      isFabVisible = true;
    }
    setState(() {
      _isFabVisible = isFabVisible!;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void addDataInitialisation(List<dynamic> data) {
    Provider.of<ContactData>(context, listen: false).initializeContact(data);
  }

  void refreshContactList() async {
    int count = 1;
    while (count <= 2) {
      final response = await http.get(
        Uri.parse("https://reqres.in/api/users?page=$count"),
      );
      final json = jsonDecode(response.body);
      addDataInitialisation(json["data"] as List<dynamic>);
      count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Contacts"),
        actions: [
          IconButton(
            onPressed: refreshContactList,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: SizedBox(
        child: Column(
          children: [
            Container(
              decoration: decorationCircular(Colors.white, 35),
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 20,
                left: 25,
                right: 25,
              ),
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Contact",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              width: getSize(context).height * 1,
              height: getSize(context).width * 0.08,
              child: Row(
                children: [buttonTile("All", 0), buttonTile("Favourite", 1)],
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) => setState(() {
                  indexPage = index;
                }),
                children: [
                  Home(onScroll: _scrollController),
                  const Favourite(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: _isFabVisible,
        child: Container(
          margin: const EdgeInsets.only(right: 30, bottom: 15),
          child: const FloatingActionButton(
            onPressed: null,
            shape: CircleBorder(),
            child: Icon(Icons.add),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Container(), label: ""),
          BottomNavigationBarItem(icon: Container(), label: ""),
        ],
      ),
    );
  }

  Container buttonTile(String title, int pagePosition) {
    return Container(
      decoration: decorationCircular(
          pagePosition == indexPage
              ? Theme.of(context).primaryColor
              : Colors.white,
          10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () => pageController.jumpToPage(pagePosition),
        child: Text(title),
      ),
    );
  }
}
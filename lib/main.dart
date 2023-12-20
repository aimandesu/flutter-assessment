import 'package:flutter/material.dart';
import 'package:flutter_assessment/pages.dart';
import 'package:flutter_assessment/provider/contact_data.dart';
import 'package:flutter_assessment/screen/profile/profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ContactData(),
        ),
      ],
      child: MaterialApp(
        title: 'My Contacts',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF32BAA5)),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            color: Color(0xFF32BAA5),
          ),
          primaryColor: const Color(0xFF32BAA5),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF32BAA5),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const Pages(),
        routes: {
          Profile.routeName: (_) => const Profile(),
        },
      ),
    );
  }
}

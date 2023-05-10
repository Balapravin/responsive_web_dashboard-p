// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsivedasboard/Screen/dashboard.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final themeModedata = ref.watch(themeModeProvider);    
      log(themeModedata.toString());
    return MaterialApp(
      title: 'Bala Web',
      debugShowCheckedModeBanner: false,
      themeMode: themeModedata,
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/Dashboard",
      routes: {"/Dashboard": (context) => Dashboard()},
    );
  }
}



class DarkModeChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
builder:(context, ref, child) {
  final isDarkMode = ref.watch(isDarkModeProvider);
  return  CupertinoSwitch(
            value: isDarkMode,
            onChanged: (value) {
              if (value) {
                ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
              } else {
                ref.read(themeModeProvider.notifier).state =ThemeMode.light;
              }
              
            });
},
    );
  }
}

final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  return themeMode == ThemeMode.dark;
});


final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
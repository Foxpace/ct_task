import 'package:ct_task/bloc_module/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:ct_task/res/strings.dart';
import 'package:ct_task/widgets/main_page.dart';
import 'package:ct_task/theme.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(CtTask());
}

class CtTask extends MaterialApp {
  CtTask({Key? key})
      : super(
      key: key,
      title: Strings.appTitle,
      home: const MainPage(),
      theme: appThemeData,
      darkTheme: appThemeData,
      themeMode: ThemeMode.system, // system decides, which theme to use
      debugShowCheckedModeBanner: false);
}

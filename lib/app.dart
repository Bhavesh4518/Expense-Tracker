
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Themes/app_theme.dart';
import 'app_routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      getPages: AppRoutes.pages(),
      home: const Scaffold(backgroundColor: Colors.yellowAccent,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),),
    );
  }
}


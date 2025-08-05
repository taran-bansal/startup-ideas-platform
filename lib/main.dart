import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/bindings/app_bindings.dart';
import 'app/routes/app_pages.dart';
import 'core/theme/app_theme_v2.dart';

void main() {
  // Initialize all dependencies
  Get.put(AppBindings());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Startup Ideas',
      debugShowCheckedModeBanner: false,
      theme: AppThemeV2.lightTheme,
      darkTheme: AppThemeV2.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

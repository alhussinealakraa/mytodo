import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/core/feature/model/response/todo_model.dart';
import 'package:my_todo/repository/sqlite_service.dart';

import 'core/feature/presentation/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'injection_container.dart';

void main() {
  initInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1080, 1920),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
      builder: (ctx, widget) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          routerConfig: router,
        );
      }
    );
  }
}


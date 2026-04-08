import 'package:flutter/material.dart';
import 'package:metaupspace/core/theme/app_theme.dart';
import 'package:metaupspace/features/auth/pages/login_page.dart';

class MetaApp extends StatelessWidget {
  const MetaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metaupspace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const LoginPage(),
    );
  }
}

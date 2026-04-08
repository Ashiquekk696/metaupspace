import 'package:flutter/material.dart';
import 'package:metaupspace/app.dart';
import 'package:metaupspace/core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MetaApp());
}

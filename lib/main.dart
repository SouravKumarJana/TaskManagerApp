import 'package:flutter/material.dart';
import 'widgets/app.dart';
import 'service/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotificationService.init();

  runApp(const MyApp());
}

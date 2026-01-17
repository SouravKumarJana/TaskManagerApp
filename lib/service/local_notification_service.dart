import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings =
        InitializationSettings(android: androidInit);

    await _plugin.initialize(initSettings);

  }

  static Future<void> schedule({
    required int id,
    required String title,
    required DateTime dateTime,
  }) async {
    if (dateTime.isBefore(DateTime.now())) return;

    await _plugin.zonedSchedule(
      id,
      'Task Due',
      title,
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_channel',
          'Task Notifications',
          channelDescription: 'Task due reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }
}

import '../model/task.dart';
import '../service/local_notification_service.dart';

class NotificationController {
  static Future<void> init() async {
    await LocalNotificationService.init();
  }

  static Future<void> notifyTask(Task task) async {
    await LocalNotificationService.show(
      id: task.id,
      title: 'Task Reminder',
      body: task.title,
    );
  }
}

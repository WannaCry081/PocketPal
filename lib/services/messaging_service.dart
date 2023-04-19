import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:flutter_native_timezone/flutter_native_timezone.dart";
import "package:timezone/timezone.dart" as tz;
import "package:timezone/data/latest.dart" as tz;
import "package:rxdart/rxdart.dart";


class PocketPalNotification{
  static final _notifications = FlutterLocalNotificationsPlugin();
  final onNotifications = BehaviorSubject<String>();

  Future _notificationDetails() async {
    return const NotificationDetails(
      android : AndroidNotificationDetails(
        "channelId", 
        "channelName", 
        "channelDescription",
        importance: Importance.max
      ),
      iOS: IOSNotificationDetails()
    );
  }

  Future init({ bool initScheduled = false }) async {
    AndroidInitializationSettings android = const 
      AndroidInitializationSettings("ic_wallet");

    IOSInitializationSettings ios = const 
      IOSInitializationSettings();

    final settings = InitializationSettings(
      android : android,
      iOS : ios
    );

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload!);
      }
    );

    if (initScheduled){
      tz.initializeTimeZones();

      final locationName = await FlutterNativeTimezone    
                            .getLocalTimezone();

      tz.setLocalLocation(
        tz.getLocation(locationName)
      );
    }
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return _notifications.show(
      id,
      title, 
      body, 
      await _notificationDetails(),
      payload: payload
    );
  }

  Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate
  }) async {
    return _notifications.zonedSchedule(
      id,
      title, 
      body, 
      tz.TZDateTime.from(scheduledDate, tz.local),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: 
        UILocalNotificationDateInterpretation.absoluteTime
    );
  }

}
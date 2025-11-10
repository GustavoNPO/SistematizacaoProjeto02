import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart'as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  //Inicializacao
  Future<void> initNotification() async{

    if (_isInitialized) return;
    
    //init timezone

    tz.initializeTimeZones();
    final String currentTimeZone = (await FlutterTimezone.getLocalTimezone()) as String;
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');


    const initSettingsIOS =  DarwinInitializationSettings(
      requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android:initSettingsAndroid , iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(initSettings);
  }

  //Notificacao detalhes

  NotificationDetails notificationDetails(){
    return const NotificationDetails(
      android: AndroidNotificationDetails('daily_channel_id', 'Daily Notifications', channelDescription: 'Daily Notification Channel', importance: Importance.max,
       priority: Priority.high),
       iOS: DarwinNotificationDetails(),
    );



  }

  //Mostrar Notificacao

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async{
    return notificationsPlugin.show(id, title, body, NotificationDetails());
  }

  //Agendar notificacao

  Future<void> scheduleNOtification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  })async{
    //Pegar data e hora local
    final now = tz.TZDateTime.now(tz.local);

    //Criar 

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    //Agendar a notificacao

    await notificationsPlugin.zonedSchedule(
      id, 
      title,
      body,
      scheduledDate,
      const NotificationDetails(),

      
      androidScheduleMode:AndroidScheduleMode.inexactAllowWhileIdle,
      
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
  }
}
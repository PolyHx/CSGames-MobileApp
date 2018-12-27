import 'package:PolyHxApp/domain/notification.dart';

class LoadNotificationsAction {
  final String eventId;
  
  LoadNotificationsAction(this.eventId);
}

class NotificationsLoadedAction {
  final List<AppNotification> notifications;

  NotificationsLoadedAction(this.notifications);
}

class NotificationsNotLoadedAction {}

class ResetNotificationsAction {}

class SendSms {
  final String eventId;
  final String message;

  SendSms(this.eventId, this.message);
}

class SmsNotSentAction {}

class SmsSentAction {}

class SetupNotificationAction {}
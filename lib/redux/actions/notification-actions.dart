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
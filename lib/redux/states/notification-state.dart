import 'package:PolyHxApp/domain/notification.dart';
import 'package:meta/meta.dart';

@immutable
class NotificationState {
  final List<AppNotification> notifications;
  final bool isLoading;
  final bool hasErrors;
  final bool smsSent;

  NotificationState({this.notifications, this.isLoading, this.hasErrors, this.smsSent});

  factory NotificationState.initial() => NotificationState(notifications: [], isLoading: false, hasErrors: false, smsSent: false);

  factory NotificationState.loading() => NotificationState(notifications: [], isLoading: true, hasErrors: false, smsSent: false);

  factory NotificationState.error() => NotificationState(notifications: [], isLoading: false, hasErrors: true, smsSent: false);

  factory NotificationState.sent() => NotificationState(notifications: [], isLoading: false, hasErrors: false, smsSent: true);
}
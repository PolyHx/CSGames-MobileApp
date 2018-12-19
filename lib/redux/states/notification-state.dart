import 'package:PolyHxApp/domain/notification.dart';
import 'package:meta/meta.dart';

@immutable
class NotificationState {
  final List<AppNotification> notifications;
  final bool isLoading;
  final bool hasErrors;

  NotificationState({this.notifications, this.isLoading, this.hasErrors});

  factory NotificationState.initial() => NotificationState(notifications: [], isLoading: false, hasErrors: false);

  factory NotificationState.loading() => NotificationState(notifications: [], isLoading: true, hasErrors: false);

  factory NotificationState.error() => NotificationState(notifications: [], isLoading: false, hasErrors: true);
}
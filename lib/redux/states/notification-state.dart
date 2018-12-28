import 'package:PolyHxApp/domain/notification.dart';
import 'package:meta/meta.dart';

@immutable
class NotificationState {
  final List<AppNotification> notifications;
  final bool isLoading;
  final bool hasErrors;
  final bool smsSent;
  final bool hasUnseenNotifications;

  NotificationState({this.notifications, this.isLoading, this.hasErrors, this.smsSent, this.hasUnseenNotifications});

  factory NotificationState.initial() => NotificationState(
    notifications: [],
    isLoading: false,
    hasErrors: false,
    smsSent: false,
    hasUnseenNotifications: false
  );

  factory NotificationState.loading() => NotificationState(
    notifications: [],
    isLoading: true,
    hasErrors: false,
    smsSent: false,
    hasUnseenNotifications: false
  );

  factory NotificationState.error() => NotificationState(
    notifications: [],
    isLoading: false,
    hasErrors: true,
    smsSent: false,
    hasUnseenNotifications: false
  );

  factory NotificationState.sent() => NotificationState(
    notifications: [],
    isLoading: false,
    hasErrors: false,
    smsSent: true,
    hasUnseenNotifications: false
  );

  factory NotificationState.unseen() => NotificationState(
    notifications: [],
    isLoading: false,
    hasErrors: false,
    smsSent: false,
    hasUnseenNotifications: true
  );
}
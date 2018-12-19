import 'package:PolyHxApp/redux/actions/notification-actions.dart';
import 'package:PolyHxApp/redux/states/notification-state.dart';
import 'package:redux/redux.dart';

final notificationReducer = combineReducers<NotificationState>([
  TypedReducer<NotificationState, LoadNotificationsAction>(_onLoadNotifications),
  TypedReducer<NotificationState, NotificationsNotLoadedAction>(_onError),
  TypedReducer<NotificationState, NotificationsLoadedAction>(_setNotifications),
  TypedReducer<NotificationState, ResetNotificationsAction>(_setInitial)
]);

NotificationState _onLoadNotifications(NotificationState state, LoadNotificationsAction action) {
  return NotificationState.loading();
}

NotificationState _onError(NotificationState state, NotificationsNotLoadedAction action) {
  return NotificationState.error();
}

NotificationState _setNotifications(NotificationState state, NotificationsLoadedAction action) {
  return NotificationState(notifications: action.notifications, isLoading: false, hasErrors: false);
}

NotificationState _setInitial(NotificationState state, ResetNotificationsAction action) {
  return NotificationState.initial();
}
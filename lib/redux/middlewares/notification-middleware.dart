import 'package:PolyHxApp/redux/actions/notification-actions.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/services/notification.service.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class NotificationMiddleware implements EpicClass<AppState> {
  final NotificationService _notificationService;

  NotificationMiddleware(this._notificationService);

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return Observable(actions)
      .ofType(TypeToken<LoadNotificationsAction>())
      .switchMap((action) => _fetchNotifications(action.eventId));
  }

  Stream<dynamic> _fetchNotifications(String eventId) async* {
    try {
      yield NotificationsLoadedAction(await _notificationService.getNotificationsForEvent(eventId));
    } catch(err) {
      print('An error occured while getting the notifications: $err');
      yield NotificationsNotLoadedAction();
    }
  }
}
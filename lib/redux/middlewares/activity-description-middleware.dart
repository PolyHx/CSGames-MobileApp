import 'package:PolyHxApp/redux/actions/activity-description-actions.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/services/activities.service.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class ActivityDescriptionMiddleware extends EpicClass<AppState> {
  final ActivitiesService _activitiesService;

  ActivityDescriptionMiddleware(this._activitiesService);

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return Observable.merge([
      Observable(actions)
        .ofType(TypeToken<SubscribeAction>())
        .switchMap((action) => _subscribe(action.activityId, action.attendeeId)),
      Observable(actions)
        .ofType(TypeToken<VerifySubscriptionAction>())
        .switchMap((action) => _verify(action.activityId, action.attendeeId))
    ]);
  }

  Stream<dynamic> _subscribe(String activityId, String attendeeId) async* {
    if (attendeeId == '') {
      yield NotSubscribedAction();
      return;
    }

    yield SubscribedAction(await _activitiesService.addSubscriptionToActivity(attendeeId, activityId));
    return;
  }

  Stream<dynamic> _verify(String activityId, String attendeeId) async* {
    if (attendeeId == '') {
      yield NotSubscribedAction();
      return;
    }

    yield SubscribedAction(await _activitiesService.verifyAttendeeSubscription(attendeeId, activityId));
    return;
  }
}
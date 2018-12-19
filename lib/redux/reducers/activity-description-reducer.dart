import 'package:PolyHxApp/redux/actions/activity-description-actions.dart';
import 'package:PolyHxApp/redux/states/activity-description-state.dart';
import 'package:redux/redux.dart';

final activityDescriptionReducer = combineReducers<ActivityDescriptionState>([
  TypedReducer<ActivityDescriptionState, SubscribeAction>(_setLoading),
  TypedReducer<ActivityDescriptionState, NotSubscribedAction>(_setError),
  TypedReducer<ActivityDescriptionState, SubscribedAction>(_setSubscribed)
]);

ActivityDescriptionState _setLoading(ActivityDescriptionState state, SubscribeAction action) {
  return ActivityDescriptionState.loading();
}

ActivityDescriptionState _setError(ActivityDescriptionState state, NotSubscribedAction action) {
  return ActivityDescriptionState.error();
}

ActivityDescriptionState _setSubscribed(ActivityDescriptionState state, SubscribedAction action) {
  return ActivityDescriptionState(hasErrors: false, isLoading: false, isSubscribed: action.isSubscribed);
}
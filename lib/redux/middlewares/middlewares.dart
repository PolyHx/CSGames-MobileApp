import 'package:redux/redux.dart';
import 'package:PolyHxApp/redux/actions/actions.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/services/events.service.dart';

List<Middleware<AppState>> createEventsMiddleware(EventsService eventManagement) {
  final loadEvents = _createLoadEvents(eventManagement);
  
  return combineTypedMiddleware([
    new MiddlewareBinding<AppState, LoadEventsAction>(loadEvents)
  ]);
}

Middleware<AppState> _createLoadEvents(EventsService eventManagement) {
  return (Store<AppState> store, action, NextDispatcher next) {
    eventManagement.getAllEvents().then((events) {
      store.dispatch(new EventsLoadedAction(events));
    }).catchError((_) => store.dispatch(new EventsNotLoadedAction()));
    next(action);
  };
}
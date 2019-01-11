import 'dart:async';

import 'package:PolyHxApp/domain/user.dart';
import 'package:PolyHxApp/pages/info.dart';
import 'package:PolyHxApp/pages/notification-list.dart';
import 'package:PolyHxApp/pages/notification.dart';
import 'package:PolyHxApp/pages/profile.dart';
import 'package:PolyHxApp/pages/sponsors-page.dart';
import 'package:PolyHxApp/redux/actions/activities-schedule-actions.dart';
import 'package:PolyHxApp/redux/actions/attendee-retrieval-actions.dart';
import 'package:PolyHxApp/redux/actions/notification-actions.dart';
import 'package:PolyHxApp/redux/actions/sponsors-actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:PolyHxApp/domain/event.dart';
import 'package:PolyHxApp/pages/activities-schedule.dart';
import 'package:PolyHxApp/pages/attendee-retrieval.dart';
import 'package:PolyHxApp/pages/event-info.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';

class EventPage extends StatefulWidget {
    EventPage({Key key}) : super(key: key);

    @override
    _EventPageState createState() => _EventPageState();
}

enum EventTabs { Scan, Info, Sponsors, Activities, Profile }
enum VolunteerTabs { Scan, Info, Sponsors, Activities, Profile }
enum AdminEventTabs { Scan, Notification, Sponsors, Activities, Profile }

class _EventPageState extends State<EventPage> {
    int _currentTabIndex = 0;

    Widget _buildBody(_EventPageViewModel model) {
        Widget body;
        switch (EventTabs.values[_currentTabIndex]) {
            case EventTabs.Scan:
                body = InfoPage(model.event);
                break;
            case EventTabs.Info:
                body = EventInfoPage();
                break;
            case EventTabs.Activities:
                body = ActivitiesSchedulePage(model.event.id, model.user.role);
                break;
            case EventTabs.Profile:
                body = ProfilePage();
                break;
            case EventTabs.Sponsors:
                body = SponsorsPage();
                break;
            default:
                break;
        }
        return body;
    }

    Widget _buildBodyVolunteer(_EventPageViewModel model) {
        Widget body;
        switch (VolunteerTabs.values[_currentTabIndex]) {
            case VolunteerTabs.Scan:
                body = AttendeeRetrievalPage(model.event);
                break;
            case VolunteerTabs.Info:
                body = EventInfoPage();
                break;
            case VolunteerTabs.Activities:
                body = ActivitiesSchedulePage(model.event.id, model.user.role);
                break;
            case VolunteerTabs.Profile:
                body = ProfilePage();
                break;
            case VolunteerTabs.Sponsors:
                body = SponsorsPage();
                break;
            default:
                break;
        }
        return body;
    }

  Widget _buildBodyAdmin(_EventPageViewModel model) {
    Widget body;
    switch (AdminEventTabs.values[_currentTabIndex]) {
        case AdminEventTabs.Scan:
            body = AttendeeRetrievalPage(model.event);
            break;
        case AdminEventTabs.Notification:
            body = NotificationPage();
            break;
        case AdminEventTabs.Activities:
            body = ActivitiesSchedulePage(model.event.id, model.user.role);
            break;
        case AdminEventTabs.Profile:
            body = ProfilePage();
            break;
        case AdminEventTabs.Sponsors:
            body = SponsorsPage();
            break;
        default:
            break;
    }
    return body;
  }

  Future<bool> _reset(_EventPageViewModel model) async {
    model.resetAttendeeRetrieval();
    model.resetSchedule();
    model.resetSponsors();
    return true;
  }

    List<Widget> _buildItems() {
        return <Widget>[
            IconButton(
                icon: Icon(
                    FontAwesomeIcons.info,
                    color: _currentTabIndex == EventTabs.Scan.index ? Constants.polyhxRed : Colors.black
                ),
                onPressed: () {
                    setState(() => _currentTabIndex = EventTabs.Scan.index);
                }
            ),
            IconButton(
                icon: Icon(
                    FontAwesomeIcons.book,
                    color: _currentTabIndex == EventTabs.Info.index ? Constants.polyhxRed : Colors.black
                ),
                onPressed: () {
                    setState(() => _currentTabIndex = EventTabs.Info.index);
                }
            ),
            IconButton(
                icon: Icon(
                    FontAwesomeIcons.gem,
                    color: _currentTabIndex == EventTabs.Sponsors.index ? Constants.polyhxRed : Colors.black
                ),
                onPressed: () {
                    setState(() => _currentTabIndex = EventTabs.Sponsors.index);
                }
            ),
            IconButton(
                icon: Icon(
                    FontAwesomeIcons.calendar,
                    color: _currentTabIndex == EventTabs.Activities.index ? Constants.polyhxRed : Colors.black
                ),
                onPressed: () {
                    setState(() => _currentTabIndex = EventTabs.Activities.index);
                }
            ),
            IconButton(
                icon: Icon(
                    FontAwesomeIcons.userAlt,
                    color: _currentTabIndex == EventTabs.Profile.index ? Constants.polyhxRed : Colors.black
                ),
                onPressed: () {
                    setState(() => _currentTabIndex = EventTabs.Profile.index);
                }
            )
        ];
    }

    Widget _buildNavigationBar() {
        return BottomAppBar(
            elevation: 20.0,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildItems()
            )
        );
    }

    Widget _buildAppBar(BuildContext context, _EventPageViewModel model) {
        return AppBar(
            title: Text(
                model.event.name,
                style: TextStyle(fontFamily: 'OpenSans')
            ),
            actions: <Widget>[
                Stack(
                    children: <Widget>[
                        IconButton(
                            icon: Icon(FontAwesomeIcons.bell),
                            color: Colors.white,
                            onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => NotificationListPage(),
                                        fullscreenDialog: true
                                    )
                                );
                            }
                        ),
                        Positioned(
                            top: 9.0,
                            right: 9.0,
                            child: Center(
                              child: Container(
                                width: 10,
                                decoration: BoxDecoration(
                                  color: model.hasUnseenNotifications == true ? Colors.white : Colors.transparent,
                                  shape: BoxShape.circle
                                ),
                                child: Text('')
                              )
                            )
                        )
                    ]
                )  
            ]
        );
    }

    @override
    Widget build(BuildContext context) {
        return StoreConnector<AppState, _EventPageViewModel>(
            onInit: (store) => store.dispatch(CheckUnseenNotificationsAction(store.state.currentEvent.id)),
            converter: (store) => _EventPageViewModel.fromStore(store),
            builder: (BuildContext context, _EventPageViewModel model) {
                Widget body;
                switch (model.user.role) {
                    case 'admin':
                        body = _buildBodyAdmin(model);
                        break;
                    case 'volunteer':
                        body = _buildBodyVolunteer(model);
                        break;
                    default:
                        body = _buildBody(model);
                        break;
                }
                return WillPopScope(
                    onWillPop: () => _reset(model),
                    child: Scaffold(
                        appBar: _buildAppBar(context, model),
                        body: body,
                        resizeToAvoidBottomPadding: false,
                        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                        bottomNavigationBar: _buildNavigationBar()
                    )
                );
            }
        );
    }
}

class _EventPageViewModel {
  bool hasUnseenNotifications;
  Event event;
  User user;
  Function resetSchedule;
  Function resetAttendeeRetrieval;
  Function resetSponsors;

  _EventPageViewModel(
    this.hasUnseenNotifications,
    this.event,
    this.user,
    this.resetSchedule,
    this.resetAttendeeRetrieval,
    this.resetSponsors
  );

  _EventPageViewModel.fromStore(Store<AppState> store) {
    hasUnseenNotifications = store.state.notificationState.hasUnseenNotifications;
    event = store.state.currentEvent;
    user = store.state.currentUser;
    resetSchedule = () => store.dispatch(ResetScheduleAction());
    resetAttendeeRetrieval = () => store.dispatch(ResetAttendeeAction());
    resetSponsors = () => store.dispatch(ResetSponsorsAction());
  }
}
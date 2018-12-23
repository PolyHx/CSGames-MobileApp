import 'package:PolyHxApp/domain/user.dart';
import 'package:PolyHxApp/pages/info.dart';
import 'package:PolyHxApp/pages/notification-list.dart';
import 'package:PolyHxApp/pages/profile.dart';
import 'package:PolyHxApp/pages/sponsors-page.dart';
import 'package:PolyHxApp/redux/actions/activities-schedule-actions.dart';
import 'package:PolyHxApp/redux/actions/attendee-retrieval-actions.dart';
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

enum EventTabs { Info, Sponsors, Scan, Activities, Profile }
enum VolunteerTabs { Info, Sponsors, Scan, Activities, Profile }
enum AdminEventTabs { Notification, Sponsors, Scan, Activities, Profile }

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
        body = EventInfoPage();
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
      Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: IconButton(
          icon: Icon(
            FontAwesomeIcons.book,
            size: 30.0,
            color: _currentTabIndex == EventTabs.Info.index ? Constants.polyhxRed : Colors.black
          ),
          onPressed: () {
            setState(() => _currentTabIndex = EventTabs.Info.index);
          }
        )
      ),
      Padding(
        padding: EdgeInsets.only(left: 30.0),
        child: IconButton(
          icon: Icon(
            FontAwesomeIcons.gem,
            size: 30.0,
            color: _currentTabIndex == EventTabs.Sponsors.index ? Constants.polyhxRed : Colors.black
          ),
          onPressed: () {
            setState(() => _currentTabIndex = EventTabs.Sponsors.index);
          }
        )
      ),
      Padding(
        padding: EdgeInsets.only(left: 120.0),
        child: IconButton(
          icon: Icon(
            FontAwesomeIcons.calendar,
            size: 30.0,
            color: _currentTabIndex == EventTabs.Activities.index ? Constants.polyhxRed : Colors.black
          ),
          onPressed: () {
            setState(() => _currentTabIndex = EventTabs.Activities.index);
          }
        )
      ),
      Padding(
        padding: EdgeInsets.only(left: 35.0),
        child: IconButton(
          icon: Icon(
            FontAwesomeIcons.userAlt,
            size: 30.0,
            color: _currentTabIndex == EventTabs.Profile.index ? Constants.polyhxRed : Colors.black
          ),
          onPressed: () {
            setState(() => _currentTabIndex = EventTabs.Profile.index);
          }
        )
      )
    ];
  }

  Widget _buildActionButton(_EventPageViewModel model) {
    return Container(
      height: 140.0,
      width: 140.0,
      child: Padding(
        padding: EdgeInsets.only(top: 60.0),
        child: FloatingActionButton(
          backgroundColor: Constants.polyhxRed,
          child: Icon(
            model.user.role == 'admin' || model.user.role == 'volunteer' ? Icons.camera_alt : FontAwesomeIcons.info,
            color: Colors.white,
            size: 40.0
          ),
          onPressed: () {
            setState(() => _currentTabIndex = EventTabs.Scan.index);
          }
        )
      )
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      height: 65.0,
      child: Material(
        elevation: 40.0,
        child: BottomAppBar(
          elevation: 20.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: _buildItems()
          )
        )
      )
    );
  }

  Widget _buildAppBar(BuildContext context, _EventPageViewModel model) {
    return AppBar(
      title: Text(
        model.event.name,
        style: TextStyle(fontFamily: 'Raleway')
      ),
      actions: <Widget>[
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
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _EventPageViewModel>(
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
            floatingActionButton: _buildActionButton(model),
            bottomNavigationBar: _buildNavigationBar()
          )
        );
      }
    );
  }
}

class _EventPageViewModel {
  Event event;
  User user;
  Function resetSchedule;
  Function resetAttendeeRetrieval;
  Function resetSponsors;

  _EventPageViewModel(
    this.event,
    this.user,
    this.resetSchedule,
    this.resetAttendeeRetrieval,
    this.resetSponsors,
  );

  _EventPageViewModel.fromStore(Store<AppState> store) {
    event = store.state.currentEvent;
    user = store.state.currentUser;
    resetSchedule = () => store.dispatch(ResetScheduleAction());
    resetAttendeeRetrieval = () => store.dispatch(ResetAttendeeAction());
    resetSponsors = () => store.dispatch(ResetSponsorsAction());
  }
}
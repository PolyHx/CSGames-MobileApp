import 'package:PolyHxApp/components/pill-button.dart';
import 'package:PolyHxApp/components/title.dart';
import 'package:PolyHxApp/redux/actions/notification-actions.dart';
import 'package:PolyHxApp/redux/state.dart';
import 'package:PolyHxApp/services/localization.service.dart';
import 'package:PolyHxApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _smsBody;
  String _pushBody;
  String _pushTitle;
  final TextEditingController _controller = TextEditingController();

  Widget _buildSmsTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Text(
        LocalizationService.of(context).notification['sms'],
        style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 30.0
        )
      )
    );
  }

  Widget _buildTextField(BuildContext context, _NotificationViewModel model) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(labelText: LocalizationService.of(context).notification['sms-text']),
        onChanged: (_val) {
          _smsBody = _val;
          if (model.smsSent && _smsBody != '') {
            model.reset();
          }
        },
        controller: _controller
      )
    );
    
  }

  Widget _buildSendButton(BuildContext context, VoidCallback onPressed) {
    return Center(
      child: PillButton(
        color: Constants.polyhxRed,
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.fromLTRB(25.0, 12.5, 25.0, 12.5),
          child: Text(
            LocalizationService.of(context).notification['send'],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            )
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _NotificationViewModel>(
      converter: (store) => _NotificationViewModel.fromStore(store),
      builder: (BuildContext _, _NotificationViewModel model) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppTitle(LocalizationService.of(context).notification['title'], MainAxisAlignment.start),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSmsTitle(context),
                  model.smsSent ? Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(
                      FontAwesomeIcons.checkCircle,
                      color: Colors.green,
                    )
                  ) : Container()
                ]
              ),
              _buildTextField(context, model),
              _buildSendButton(context, () {
                if (_smsBody != '') model.sendSms(_smsBody);
              }),
            ]
          )
        );
      },
      onDidChange: (model) {
        if (model.smsSent) {
          _smsBody = '';
          _controller.clear();
          FocusScope.of(context).requestFocus(FocusNode());
        }
      }
    );
  }
}

class _NotificationViewModel {
  bool smsSent;
  Function sendSms;
  Function reset;

  _NotificationViewModel(this.smsSent, this.sendSms);

  _NotificationViewModel.fromStore(Store<AppState> store) {
    smsSent = store.state.notificationState.smsSent;
    sendSms = (message) => store.dispatch(SendSmsAction(store.state.currentEvent.id, message));
    reset = () => store.dispatch(ResetNotificationsAction());
  }
}
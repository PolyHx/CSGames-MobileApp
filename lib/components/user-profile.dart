import 'package:CSGamesApp/domain/attendee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:CSGamesApp/components/circle-gravatar.dart';
import 'package:CSGamesApp/utils/constants.dart';

class UserProfile extends StatelessWidget {
  final Attendee _attendee;
  final Widget content;
  final Color color;
  final double elevation;
  final double opacity;
  final StackFit fit;

  UserProfile(this._attendee,
      {
        this.content,
        this.color = Colors.white,
        this.elevation = 1.0,
        this.opacity = 1.0,
        this.fit = StackFit.expand,
      });

  Widget _buildNameWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: Text('${_attendee.firstName} ${_attendee.lastName}',
          style: TextStyle(
            color: Constants.polyhxGrey,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: EdgeInsets.only(top: 40.0),
        child: Opacity(
          opacity: opacity,
          child: Material(
            elevation: elevation,
            borderRadius: BorderRadius.circular(10.0),
            child: Column(
              children: <Widget>[
                _buildNameWidget(),
                Container(
                  child: content,
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget _buildAvatar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CircleGravatar(_attendee.email),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: fit,
      children: <Widget>[
        _buildBody(),
        _buildAvatar(),
      ],
    );
  }
}
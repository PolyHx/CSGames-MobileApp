import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:PolyHxApp/components/loadingspinner.dart';
import 'package:PolyHxApp/components/pagetransformer/eventpageitem.dart';
import 'package:PolyHxApp/components/pagetransformer/pagetransformer.dart';
import 'package:PolyHxApp/domain/event.dart';
import 'package:PolyHxApp/services/event-management.dart';
import 'package:PolyHxApp/services/token.service.dart';
import 'package:PolyHxApp/utils/routes.dart';

class EventList extends StatelessWidget {
  final TokenService _tokenService;
  final EventManagementService _eventManagementService;

  EventList(this._tokenService, this._eventManagementService);

  Future<bool> isLoggedIn() async {
    return _tokenService.validateTokens();
  }

  Future<List<Event>> fetchAllEvents() async {
    return _eventManagementService.getAllEvents();
  }

  Widget _buildEventCards() {
    return new FutureBuilder(
        future: fetchAllEvents(),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Scaffold(body: new Center(child: new LoadingSpinner()));
          } else {
            if (!snapshot.hasError && snapshot.data != null) {
              return new PageTransformer(
                pageViewBuilder: (context, visibilityResolver) {
                  return new PageView.builder(
                    controller: new PageController(viewportFraction: 0.85),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data[index];
                      final pageVisibility =
                          visibilityResolver.resolvePageVisibility(index);

                      return new EventPageItem(
                        item: item,
                        pageVisibility: pageVisibility,
                        onTap: () => Navigator
                            .of(context)
                            .pushNamed("${Routes.EVENT}/${item.id}"),
                      );
                    },
                  );
                },
              );
            } else {
              print(snapshot.data);
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Scaffold(body: new Center(child: new LoadingSpinner()));
          } else {
            if (!snapshot.hasError && snapshot.data != null && snapshot.data) {
              return new Scaffold(
                appBar: new AppBar(
                  title: new Text("Events"),
                  leading: new IconButton(
                      icon: new Icon(Icons.view_headline),
                      color: Colors.white,
                      onPressed: null),
                ),
                body: new Center(
                  child: new SizedBox.fromSize(child: _buildEventCards()),
                ),
              );
            } else {
              new Future.delayed(
                  new Duration(milliseconds: 1),
                  () =>
                      Navigator.of(context).pushReplacementNamed(Routes.LOGIN));
              return new Container();
            }
          }
        });
  }
}

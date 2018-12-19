import 'package:meta/meta.dart';

@immutable
class ActivityDescriptionState {
  final bool isLoading;
  final bool hasErrors;
  final bool isSubscribed;

  ActivityDescriptionState({this.hasErrors, this.isLoading, this.isSubscribed});

  factory ActivityDescriptionState.initial() => ActivityDescriptionState(hasErrors: false, isLoading: false, isSubscribed: false);

  factory ActivityDescriptionState.loading() => ActivityDescriptionState(hasErrors: false, isLoading: true, isSubscribed: false);

  factory ActivityDescriptionState.error() => ActivityDescriptionState(hasErrors: true, isLoading: true, isSubscribed: false);
}
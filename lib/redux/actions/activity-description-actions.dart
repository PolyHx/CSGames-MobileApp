class SubscribeAction {
  final String activityId;
  final String attendeeId;

  SubscribeAction(this.activityId, this.attendeeId);
}

class NotSubscribedAction {}

class SubscribedAction {
  final bool isSubscribed;

  SubscribedAction(this.isSubscribed);
}

class VerifySubscriptionAction {
  final String activityId;
  final String attendeeId;

  VerifySubscriptionAction(this.activityId, this.attendeeId);
}
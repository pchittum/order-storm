public with sharing class InboundOrderPublisher {
  public static Database.SaveResult publishEvent(String msg) {
    // publish a single event in order to validate the event being wired up
    Inbound_Order__e orderEvent = new Inbound_Order__e(
      Status__c = msg,
      Type__c = 'Express'
    );

    Database.SaveResult result = EventBus.publish(orderEvent);

    return result;
  }

  public static List<Database.SaveResult> publishEvents(
    Integer evtCount,
    String msg
  ) {
    // publish a set of events in order to validate the event being wired up
    List<Inbound_Order__e> orderEvents = new List<Inbound_Order__e>();

    for (Integer i = 0; i < evtCount; i++) {
      Inbound_Order__e orderEvent = new Inbound_Order__e(
        Status__c = msg,
        Type__c = 'Saver'
      );

      orderEvents.add(orderEvent);
    }

    List<Database.SaveResult> results = EventBus.publish(orderEvents);
    return results;
  }
}

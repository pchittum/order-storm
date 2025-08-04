public with sharing class InboundOrderPublisher {
  // used to publish events to the subscriber with many partitions
  @future
  public static void publishEvents(
    Integer evtCount,
    String msg,
    String traceId
  ) {
    List<Inbound_Order__e> orderEvents = new List<Inbound_Order__e>();

    for (Integer i = 0; i < evtCount; i++) {
      Inbound_Order__e orderEvent = new Inbound_Order__e(
        Status__c = msg,
        Type__c = 'Saver',
        Trace_Id__c = traceId
      );

      orderEvents.add(orderEvent);
    }

    List<Database.SaveResult> results = EventBus.publish(orderEvents);
    return;
  }

  // duplicate event publisher for the platform event with 1 partition
  @future
  public static void publishEvents1Sub(
    Integer evtCount,
    String msg,
    String traceId
  ) {
    List<Inbound_Order_1sub__e> orderEvents = new List<Inbound_Order_1sub__e>();

    for (Integer i = 0; i < evtCount; i++) {
      Inbound_Order_1sub__e orderEvent = new Inbound_Order_1sub__e(
        Status__c = msg,
        Type__c = 'Saver',
        Trace_Id__c = traceId
      );

      orderEvents.add(orderEvent);
    }

    List<Database.SaveResult> results = EventBus.publish(orderEvents);
    return;
  }

  // for testing initial setup before testing 50k events
  public static void publishEvent(String traceId) {
    // publish a single event in order to validate the event being wired up
    Inbound_Order__e orderEvent = new Inbound_Order__e(
      Status__c = 'Multi Subscriber',
      Type__c = 'Express',
      Trace_Id__c = traceId
    );

    Database.SaveResult resultMulti = EventBus.publish(orderEvent);

    Inbound_Order_1sub__e orderEvent1Sub = new Inbound_Order_1sub__e(
      Status__c = 'Single Subscriber',
      Type__c = 'Express',
      Trace_Id__c = traceId
    );

    Database.SaveResult resultSingle = EventBus.publish(orderEvent1Sub);

    return;
  }
}

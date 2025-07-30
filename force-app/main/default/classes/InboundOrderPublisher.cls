public with sharing class InboundOrderPublisher {
  public static void publishEvent() {
    // publish a single event in order to validate the event being wired up
    Inbound_Order__e orderEvent = new Inbound_Order__e(
      Status__c = 'Multi Subscriber',
      Type__c = 'Express',
      Trace_Id__c = getTraceId()
    );

    Database.SaveResult resultMulti = EventBus.publish(orderEvent);

    Inbound_Order_1sub__e orderEvent1Sub = new Inbound_Order_1sub__e(
      Status__c = 'Single Subscriber',
      Type__c = 'Express',
      Trace_Id__c = getTraceId()
    );

    Database.SaveResult resultSingle = EventBus.publish(orderEvent1Sub);

    return;
  }

  @future
  public static void publishEvents(Integer evtCount, String msg) {
    // publish a set of events in order to validate the event being wired up
    List<Inbound_Order__e> orderEvents = new List<Inbound_Order__e>();

    for (Integer i = 0; i < evtCount; i++) {
      Inbound_Order__e orderEvent = new Inbound_Order__e(
        Status__c = msg,
        Type__c = 'Saver',
        Trace_Id__c = getTraceId()
      );

      orderEvents.add(orderEvent);
    }

    List<Database.SaveResult> results = EventBus.publish(orderEvents);
    return;
  }

  @future
  public static void publishEvents1Sub(Integer evtCount, String msg) {
    // publish a set of events in order to validate the event being wired up
    List<Inbound_Order_1sub__e> orderEvents = new List<Inbound_Order_1sub__e>();

    for (Integer i = 0; i < evtCount; i++) {
      Inbound_Order_1sub__e orderEvent = new Inbound_Order_1sub__e(
        Status__c = msg,
        Type__c = 'Saver',
        Trace_Id__c = getTraceId()
      );

      orderEvents.add(orderEvent);
    }

    List<Database.SaveResult> results = EventBus.publish(orderEvents);
    return;
  }

  private static String getTraceId() {
    return UUID.randomUUID().toString();
  }
}

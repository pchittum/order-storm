public with sharing class InboundOrderEventSubHandler {
  // single generic SObject method to process both sets of events.

  public static void handleInboundOrders(List<SObject> orderEvents) {
    // used to capture metrics about the processing of platform events
    String batchId = UUID.randomUUID().toString();
    String eventName = orderEvents.getSObjectType().getDescribe().name;
    Datetime timestamp = System.now();

    // store start trace record
    Tracer.trace(
      (String) orderEvents[0].get('Trace_Id__c'),
      batchId,
      'Trace point start',
      eventName,
      orderEvents.size(),
      timestamp
    );

    // straightforward processing of sobject (in this case platform events)
    // remember that PE trigger batch sizes are up to 2000
    List<Inbound_Order_Status__c> ordersToInsert = new List<Inbound_Order_Status__c>();

    for (SObject orderEvent : orderEvents) {
      Inbound_Order_Status__c orderStatus = new Inbound_Order_Status__c();
      orderStatus.Status__c = (String) orderEvent.get('Status__c');
      orderStatus.Event_Uuid__c = (String) orderEvent.get('EventUuid');
      orderStatus.Order_Type__c = (String) orderEvent.get('Type__c');
      orderStatus.Trace_Id__c = (String) orderEvent.get('Trace_Id__c');
      orderStatus.Batch_Id__c = batchId;
      orderStatus.Platform_Event_Name__c = eventName;

      ordersToInsert.add(orderStatus);
    }

    insert ordersToInsert;

    // fetch new timestamp for end trace
    timestamp = System.now();

    // store end trace record
    Tracer.trace(
      (String) orderEvents[0].get('Trace_Id__c'),
      batchId,
      'Trace point stop',
      eventName,
      orderEvents.size(),
      timestamp
    );
  }
}

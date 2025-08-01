public with sharing class InboundOrderEventSubHandler {
  // public static void handleInboundOrders(List<Inbound_Order__e> orderEvents) {
  //   List<Inbound_Order_Status__c> ordersToInsert = new List<Inbound_Order_Status__c>();

  //   System.debug(orderEvents[0].Status__c);

  //   for (Inbound_Order__e orderEvent : orderEvents) {
  //     Inbound_Order_Status__c orderStatus = new Inbound_Order_Status__c();
  //     orderStatus.Status__c = orderEvent.Status__c;
  //     orderStatus.Event_Uuid__c = orderEvent.EventUuid;
  //     orderStatus.Order_Type__c = orderEvent.Type__c;
  //     ordersToInsert.add(orderStatus);
  //   }

  //   insert ordersToInsert;
  // }

  // // todo: make the above method use generic sobject types and get rid of this one
  // public static void handleInboundOrdersSingle(
  //   List<Inbound_Order_1sub__e> orderEvents
  // ) {
  //   List<Inbound_Order_Status__c> ordersToInsert = new List<Inbound_Order_Status__c>();

  //   System.debug(orderEvents[0].Status__c);

  //   for (Inbound_Order_1sub__e orderEvent : orderEvents) {
  //     Inbound_Order_Status__c orderStatus = new Inbound_Order_Status__c();
  //     orderStatus.Status__c = orderEvent.Status__c;
  //     orderStatus.Event_Uuid__c = orderEvent.EventUuid;
  //     orderStatus.Order_Type__c = orderEvent.Type__c;
  //     orderStatus.Trace_Id__c = orderEvent.Trace_Id__c;
  //     ordersToInsert.add(orderStatus);
  //   }

  //   insert ordersToInsert;
  // }

  public static void handleInboundOrders(List<SObject> orderEvents) {
    String batchId = UUID.randomUUID().toString();
    String eventName = orderEvents.getSObjectType().getDescribe().name;
    Datetime timestamp = System.now();

    Tracer.trace(
      (String) orderEvents[0].get('Trace_Id__c'),
      batchId,
      'Trace point start',
      eventName,
      orderEvents.size(),
      timestamp
    );

    List<Inbound_Order_Status__c> ordersToInsert = new List<Inbound_Order_Status__c>();

    System.debug(orderEvents[0].get('Status__c'));

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

    timestamp = System.now();

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

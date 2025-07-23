public with sharing class InboundOrderEventSubHandler {
  public static void handleInboundOrders(List<Inbound_Order__e> orderEvents) {
    List<Inbound_Order_Status__c> ordersToInsert = new List<Inbound_Order_Status__c>();

    for (Inbound_Order__e orderEvent : orderEvents) {
      Inbound_Order_Status__c orderStatus = new Inbound_Order_Status__c();
      orderStatus.Status__c = orderEvent.Status__c;
      ordersToInsert.add(orderStatus);
    }

    insert ordersToInsert;
  }
}

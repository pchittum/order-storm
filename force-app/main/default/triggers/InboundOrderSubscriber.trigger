trigger InboundOrderSubscriber on Inbound_Order__e(after insert) {
  // initially wiring up the PE subscriber to receive events and store in custom object
  // TODO: break out logic into trigger handler
  // TODO: generate order and all related objects, which is big
  // TODO: setup for parallel subscriptions

  List<Inbound_Order_Status__c> ordersToInsert = new List<Inbound_Order_Status__c>();

  for (Inbound_Order__e orderEvent : Trigger.new) {
    Inbound_Order_Status__c orderStatus = new Inbound_Order_Status__c();
    orderStatus.Status__c = orderEvent.Status__c;
    ordersToInsert.add(orderStatus);
  }

  insert ordersToInsert;

}

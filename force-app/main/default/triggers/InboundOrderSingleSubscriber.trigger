trigger InboundOrderSingleSubscriber on Inbound_Order_1sub__e(after insert) {
  // initially wiring up the PE subscriber to receive events and store in custom object
  // X TODO: break out logic into trigger handler
  // TODO: generate order and all related objects, which is big
  // TODO: setup for parallel subscriptions
  System.debug('Start Platform Event Trigger');

  InboundOrderEventSubHandler.handleInboundOrders((List<SObject>) Trigger.new);

  System.debug('End Platform Event Trigger');
}

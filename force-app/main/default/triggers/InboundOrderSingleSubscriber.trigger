trigger InboundOrderSingleSubscriber on Inbound_Order_1sub__e(after insert) {
  // This subscriber has a single partition
  System.debug('Start Platform Event Trigger');

  InboundOrderEventSubHandler.handleInboundOrders((List<SObject>) Trigger.new);

  System.debug('End Platform Event Trigger');
}

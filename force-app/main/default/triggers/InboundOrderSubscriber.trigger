trigger InboundOrderSubscriber on Inbound_Order__e(after insert) {
  System.debug('Start Platform Event Trigger');

  InboundOrderEventSubHandler.handleInboundOrders((List<SObject>) Trigger.new);

  System.debug('End Platform Event Trigger');
}

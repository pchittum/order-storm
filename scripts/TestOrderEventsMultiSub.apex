for (Integer i = 0; i < 5; i++){
    InboundOrderPublisher.publishEvents(10000, 'Multi Subscriber');
}
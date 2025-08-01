Integer batchCount = 5;     //how many times to call the publisher
Integer eventCount = 10000; //how many events to throw at the publisher each call
String traceId = UUID.randomUUID().toString();

for (Integer i = 0; i < batchCount; i++){
    InboundOrderPublisher.publishEvents(eventCount, 'Multi Subscriber', traceId);
}
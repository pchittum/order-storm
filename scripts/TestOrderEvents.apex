InboundOrderPublisher.publishEvent('Single Message');

InboundOrderPublisher.publishEvents(100, 'Many Messages');



// of course it comes back as zero. this will always be zero. SMH. 
// Integer insertCt = [Select Count() FROM Inbound_Order_Status__c];

// System.debug('Order count: ' + insertCt);
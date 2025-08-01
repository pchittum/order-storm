public with sharing class InboundOrderCleaner implements Queueable {
  public void execute(QueueableContext context) {
    System.debug(
      'Current Stack Depth' + AsyncInfo.getCurrentQueueableStackDepth()
    );
    System.debug(
      'Maximum Stack Depth' + AsyncInfo.getMaximumQueueableStackDepth()
    );

    List<Inbound_Order_Status__c> orderRecords = new List<Inbound_Order_Status__c>();

    orderRecords = [SELECT Id FROM Inbound_Order_Status__c LIMIT 10000];

    Boolean moreRecords = orderRecords.size() == 10000;

    if (orderRecords.size() > 0) {
      delete orderRecords;
    } else {
      System.debug('All records deleted');
    }

    if (
      moreRecords &&
      AsyncInfo.getCurrentQueueableStackDepth() <
      AsyncInfo.getMaximumQueueableStackDepth()
    ) {
      Id JobId = System.enqueueJob(new InboundOrderCleaner());
    } else {
      System.debug('Max queueable depth reached on delete orders.');
    }
  }
}

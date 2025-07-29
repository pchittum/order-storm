public with sharing class InboundOrderCleaner implements Queueable {
  public void execute(QueueableContext context) {
    List<Inbound_Order_Status__c> orderRecords = new List<Inbound_Order_Status__c>();

    orderRecords = [SELECT Id FROM Inbound_Order_Status__c LIMIT 10000];

    Boolean moreRecords = orderRecords.size() == 10000;

    if (orderRecords.size() > 0) {
      delete orderRecords;
    }

    if (moreRecords) {
      Id JobId = System.enqueueJob(new InboundOrderCleaner());
    }
  }
}

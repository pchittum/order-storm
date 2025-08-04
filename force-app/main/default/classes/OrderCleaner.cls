public with sharing class OrderCleaner implements Queueable {
  private Database.Cursor cursorHandle;
  private Integer position;
  private final integer batchSize = 2000; //max batch size 2000
  private String traceId;
  private String batchId;
  private String quiddity;
  private Datetime timestamp;

  public OrderCleaner() {
    this.cursorHandle = Database.getCursor(
      'SELECT Id FROM Inbound_Order_Status__c LIMIT 100000'
    );
    this.position = 0;
  }

  public void execute(QueueableContext ctx) {
    List<Inbound_Order_Status__c> orders = new List<Inbound_Order_Status__c>();

    // fetch up to DML Rows limit
    while (orders.size() < Limits.getLimitDMLRows()) {
      orders.addAll(
        (List<Inbound_Order_Status__c>) cursorHandle.fetch(position, batchSize)
      );

      position += batchSize;
    }

    delete orders;

    if (position < cursorHandle.getNumRecords()) {
      System.enqueueJob(this);
    }
  }
}

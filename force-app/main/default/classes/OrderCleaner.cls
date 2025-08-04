public with sharing class OrderCleaner implements Queueable {
  private Database.Cursor cursorHandle;
  private Integer position;
  private final integer batchSize = 2000; //max batch size 2000
  private String traceId;
  private String batchId;
  private String quiddity;
  private Datetime timestamp;

  public OrderCleaner() {
    // create the cursor to use to delete Inbound_Order_Status__c records
    // this.position ensures cursor is created only once across all
    // chained queueable calls when we re-enqueue this.
    this.cursorHandle = Database.getCursor(
      'SELECT Id FROM Inbound_Order_Status__c LIMIT 100000'
    );
    this.position = 0;
  }

  public void execute(QueueableContext ctx) {
    List<Inbound_Order_Status__c> orders = new List<Inbound_Order_Status__c>();

    // iterate fetch up to DML Rows limit
    while (orders.size() < Limits.getLimitDMLRows()) {
      orders.addAll(
        (List<Inbound_Order_Status__c>) cursorHandle.fetch(position, batchSize)
      );

      position += batchSize;
    }

    delete orders;

    // once we've fetched the equivalent number of records as are in the
    // cursor, stop enqueueing new calls.
    if (position < cursorHandle.getNumRecords()) {
      System.enqueueJob(this);
    }
  }
}

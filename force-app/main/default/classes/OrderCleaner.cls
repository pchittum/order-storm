public with sharing class OrderCleaner implements Queueable {
  // Overall async usage will be high. Could be improved
  // by fetching more chunks at once and then delete

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
    this.traceId = UUID.randomUUID().toString();
  }

  public void execute(QueueableContext ctx) {
    // String batchId = UUID.randomUUID().toString();
    // timestamp = System.now();
    // Tracer.trace(traceId, batchId, 'Starting Delete Batch', 'Order', 0, timestamp);

    List<Inbound_Order_Status__c> orders = new List<Inbound_Order_Status__c>();

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
    // timestamp = System.now();

    // Tracer.trace(traceId, batchId, 'Ending Delete Batch', 'Order', 0, timestamp);
  }
}

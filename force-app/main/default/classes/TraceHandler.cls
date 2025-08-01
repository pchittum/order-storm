public with sharing class TraceHandler implements Queueable {
  private TraceInfo trace;

  public TraceHandler(TraceInfo trace) {
    this.trace = trace;
  }

  public void execute(QueueableContext context) {
    Datetime timestamp = System.now();

    String quiddityStr = String.valueOf(trace.quiddity);

    Request_Tracker__c trackerRecord = new Request_Tracker__c(
      Name = trace.notes,
      Trace_Id__c = trace.traceId,
      Batch_Id__c = trace.batchId,
      Platform_Event_Name__c = trace.eventName,
      Event_Count__c = trace.eventCount,
      Request_Id__c = trace.requestId,
      Quiddity__c = trace.quiddity,
      Start_Time__c = trace.timestamp,
      Start_Time_Epoch__c = trace.timestamp.getTime()
    );

    Database.SaveResult result = Database.insert(trackerRecord);

    // TODO: handle failures/errors
  }
}

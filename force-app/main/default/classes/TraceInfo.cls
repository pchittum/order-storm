public with sharing class TraceInfo {
  public String traceId;
  public String batchId;
  public String notes;
  public String eventName;
  public Integer eventCount;
  public String quiddity;
  public String requestId;
  public Datetime timestamp;

  public TraceInfo(
    String traceId,
    String batchId,
    String notes,
    String eventName,
    Integer eventCount,
    String quiddity,
    String requestId,
    Datetime timestamp
  ) {
    this.traceId = traceId;
    this.batchId = batchId;
    this.notes = notes;
    this.eventName = eventName;
    this.eventCount = eventCount;
    this.quiddity = quiddity;
    this.requestId = requestId;
    this.timestamp = timestamp;
  }
}

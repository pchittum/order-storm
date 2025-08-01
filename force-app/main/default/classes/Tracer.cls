public with sharing class Tracer {
  public static void trace(
    String traceId,
    String batchId,
    String notes,
    String eventName,
    Integer eventCount,
    Datetime timestamp
  ) {
    Request reqInfo = System.Request.getCurrent();
    System.debug(notes + ' ' + reqInfo.getQuiddity());

    TraceInfo trace = new TraceInfo(
      traceId,
      batchId,
      notes,
      eventName,
      eventCount,
      String.valueOf(reqInfo.getQuiddity()),
      reqInfo.getRequestId(),
      timestamp
    );

    TraceHandler thisTrace = new TraceHandler(trace);

    System.enqueueJob(thisTrace);

    // TODO: fill out logic to call queueable and store trace records
  }
}

public with sharing class Tracer {
  public static void trace(
    String traceId,
    String notes,
    String eventName,
    Integer eventCount
  ) {
    System.debug('test');
  }
}

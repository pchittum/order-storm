AsyncOptions asyncOptions = new AsyncOptions();
asyncOptions.MaximumQueueableStackDepth = 10;

Id jobId = System.enqueueJob(new InboundOrderCleaner(), asyncOptions);
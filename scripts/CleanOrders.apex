AsyncOptions asyncOptions = new AsyncOptions();
asyncOptions.MaximumQueueableStackDepth = 50;

Id jobId = System.enqueueJob(new OrderCleaner(), asyncOptions);
# Order Storm Platform Event Parallel Subscriber Test Scenario

This project came about in exploration of the new (as of Summer 25) Salesforce platform event feature: parallel subscribers. It comprises work that was presented in the Async Apex webinar on salesforceben.com.

Parallel subscribers works in Apex subscribers only and solves for bottlenecks in high platform event throughput scenarios. By configuring 2 or more partitions, and a key on which to sort processed events, A single subscriber Apex trigger distribute events among a set of the identical subscriber.

This project is WIP and contains

- Two platform events one intended for a single partition subscriber and another for a multiple partition subscriber
- Two Apex trigger subscribers
- The PlatformEventSubscriberConfig metadata to configure each subscriber with the correct number of partitions (note this is optional for single subscriber as the default is 1 partition)
- An Apex class to launch the platform events
- An Apex trigger handler class which both subscriber triggers use
- A custom object used to store data as a result of the platform events being triggered
- Anonymous Apex scripts to launch the test scenario with 50k events
- A queueable class and Apex script to clean up order records between tests (and not run out of space)

In addition to the core use case, I became interested in measuring the performance of the partitioned subscribers so there is also:

- A custom object to store trace data
- A queueable class that's called at the stat and end of each execution batch of the platform event Trigger

This project and README are WIP and will be updated.

##Notes
Some things:

- Platform event partition key:
  - unique partition key values will create a random/semi-random distribution among parallel subs (semirandom because UUIDs are not guaranteed to be unique)
  - Sequential events with the same partition key value will be processed in order within a given partition
- Setup running user for subscriber to be able to run `log tail` as this user. Not a prod configuration necessarily.
- Setup PE enhanced usage metrics here: https://developer.salesforce.com/docs/atlas.en-us.256.0.api_meta.meta/api_meta/meta_platformeventsettings.htm
  - good to dig further into using these and working with this data
- Like many configurations that have broad impact, repartitioning is async and takes time. You can't just flip back and forth (give it a few seconds)
- Keep in mind, the tests aren't representative of performance you'd expect
  - How I'm tracing is specific to this implementation. I've tried to minimize performance impact, profiling always incurs some additional performance hit
  - Scratch org versus production/full sandbox. I imagine how Salesforce prioritises/allocates resources for some orgs is different from others...
  - **But** all tests are under the same conditions, so comparatively, I think we can still learn something generally with how these things perform.

# Sop

Scalable Object Persistence (SOP) Framework

SOP is a modern database engine within a code library. It is categorized as a NoSql engine, but which because of its scale-ability, is considered to be an enabler, coo-petition/player in the Big Data space.

Integration is one of SOP's primary goals, its ease of use, API, being part/closest! to the App & in-memory performance level were designed so it can get (optionally) utilized as a middle-ware for current RDBMS and other NoSql/Big Data engines/solution.

Code uses the Store API to store & manage key/value pairs of data. Internal Store implementation uses an enhanced, modernized B-Tree implementation that virtualizes RAM & Disk storage. Few of key enhancements to this B-Tree as compared to traditional implementations are:

* node load optimization keeps it at around 75%-98% full average load of inner & leaf nodes. Traditional B-Trees only achieve about half-full (50%) average load. This translates to a more compressed or more dense data Stores saving IT shops from costly storage hardware.
* leaf nodes' height in a particular case is tolerated not to be perfectly balanced to favor speed of deletion at zero/minimal cost in exchange. Also, the height disparity due to deletion tends to get repaired during inserts due to the node load optimization feature discussed above.
* virtualization of RAM and Disk due to the seamless-ness & effectivity of handling Btree Nodes and their app data. There is  no context switch, thus no unnecessary latency, between handling a Node in RAM and on disk.
* data block technology enables support for "very large blob" (vlblob) efficient storage and access without requiring "data streaming" concept.
* etc... a lot more enhancements waiting to be documented/cited as time permits.

SOP addresses data management scale-ability internally, at the data driver level, so when you use SOP code library, all you have to do is focus on authoring your application data solution. Nifty algorithms such as use of MRU data cache to keep frequently accessed data in memory, bulk I/O operations, B-Tree index usability optimizations, data bucketing for large data scenarios, etc... are already pre-baked, done at the driver level, so you don't have to.

Via usage of SOP API, your application will experience low latency, very high performance scalability.

# Technical Details
SOP written in Go will be a full re-implementation. A lot of key technical features of SOP will be carried over and few more will be added in order to support a master-less implementation. That is, backend Stores such as Cassandra, AWS S3 bucket will be utilized and SOP library will be master-less in order to offer a complete, 100% horizontal scaling with no hot-spotting or any application instance bottlenecks.

## Component Layout:
* SOP code library for managing key/value pair of any data type (interface{}/interface{}).
* redis for clustered, out of process data caching.
* Cassandra, AWS S3 (future next), etc... as backend Stores.
Support for additional backends other than Cassandra & AWS S3 will be done on per request basis.

# Hospital AI Data System Design Justification

## Storage Systems

For the four main goals of the hospital AI data system, I selected specialized storage systems to optimize performance, scalability, and functionality:

**Predict patient readmission risk using historical treatment data**: A data warehouse (e.g., Snowflake or Redshift) serves as the primary storage for historical treatment data. Data warehouses excel at OLAP workloads with complex queries involving aggregations and joins across large datasets. They support columnar storage for fast analytical queries and can handle the volume of historical patient data efficiently. The choice is driven by the need for high-performance analytics on structured historical data to train and deploy machine learning models for readmission prediction.

**Allow doctors to query patient history in plain English**: A vector database (e.g., Pinecone or Weaviate) stores patient history embeddings generated from NLP processing. Vector databases enable semantic similarity search, allowing natural language queries to find relevant patient information based on meaning rather than exact keyword matches. This is crucial for doctors who need intuitive access to patient histories without requiring precise medical terminology. The vector database's ability to handle high-dimensional embeddings makes it ideal for this semantic search requirement.

**Generate monthly reports for hospital management**: The same data warehouse handles reporting requirements for bed occupancy and department-wise costs. Data warehouses provide the analytical capabilities needed for complex aggregations, trend analysis, and multi-dimensional reporting that management requires. Their support for business intelligence tools and ad-hoc queries ensures that reports can be generated efficiently and flexibly.

**Stream and store real-time vitals from ICU monitoring devices**: A time-series database (e.g., InfluxDB or TimescaleDB) manages real-time vitals data. Time-series databases are optimized for high-volume, time-stamped data with efficient compression and querying capabilities for temporal patterns and real-time analytics. They can handle the continuous influx of sensor data from ICU devices while providing fast queries for monitoring and alerting.

Additionally, a traditional RDBMS (e.g., PostgreSQL) serves as the operational database for current patient records, supporting OLTP transactions like appointment scheduling and current treatment updates. This ensures ACID compliance for critical operational data.

## OLTP vs OLAP Boundary

The boundary between transactional (OLTP) and analytical (OLAP) systems occurs at the ETL pipeline. The RDBMS handles all operational transactions - patient admissions, treatment updates, billing, and current care activities. This system ensures data consistency, supports concurrent user access, and maintains referential integrity for day-to-day hospital operations. All real-time updates and transactional queries are confined to this layer to maintain performance and data integrity.

The analytical system begins when data flows through the ETL pipeline into the data warehouse. Here, data is transformed, aggregated, and optimized for complex queries and reporting. The data warehouse serves the ML models for readmission prediction, BI tools for management reports, and supports ad-hoc analytical queries. This separation ensures that analytical workloads don't impact operational performance while providing the historical context needed for AI and reporting. The time-series database and vector database operate as specialized analytical stores, receiving processed data from the ETL/streaming pipelines rather than direct transactional writes.

## Trade-offs

A significant trade-off in this design is the increased complexity of managing multiple specialized storage systems versus using a single unified database. While each system is optimized for its specific workload, this polyglot persistence approach requires additional operational overhead for data synchronization, monitoring, and maintenance. The complexity can lead to higher costs in terms of infrastructure, training, and potential points of failure.

To mitigate this trade-off, I would implement comprehensive monitoring and alerting across all systems using tools like Prometheus and Grafana, use managed cloud services (AWS, Azure, GCP) to reduce operational burden, and establish clear data governance policies with automated ETL pipelines using frameworks like Apache Airflow. Additionally, thorough documentation and training for the data engineering team would help manage the complexity, while the performance benefits justify the architectural decision for a mission-critical healthcare system. Regular architecture reviews and performance benchmarking would ensure the benefits outweigh the costs over time.
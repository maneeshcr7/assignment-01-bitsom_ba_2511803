## Anomaly Analysis

### Insert Anomaly
To insert a new customer without an associated order, it is impossible without creating a dummy order record. For example, adding a new customer C009 with name "John Doe", email "john@gmail.com", and city "Pune" would require inserting a full row with order details (order_id, product_id, etc.), even though no actual order exists. This violates data integrity as it forces the creation of unnecessary order data.

### Update Anomaly
Updating customer information requires changes across multiple rows. For instance, if customer C002 (Priya Sharma) changes her email from "priya@gmail.com" to "priya.new@gmail.com", this update must be applied to all rows where customer_id is C002. Affected rows include: row 2 (ORD1027), row 5 (ORD1002), row 7 (ORD1037), row 20 (ORD1054), row 29 (ORD1048), row 37 (ORD1094), and row 43 (ORD1035), in columns customer_email.

### Delete Anomaly
Deleting an order can inadvertently remove customer information. For example, if all orders for customer C008 (Kavya Rao) are deleted, her details (customer_name "Kavya Rao", customer_email "kavya@gmail.com", customer_city "Hyderabad") would be lost entirely, even if she remains a valid customer. Affected rows include: row 17 (ORD1131), row 25 (ORD1025), row 31 (ORD1021), row 35 (ORD1180), row 44 (ORD1047), and row 45 (ORD1090).

## Normalization Justification

While my manager argues that maintaining a single flat table is simpler and that normalization represents unnecessary over-engineering, I strongly refute this position. Normalization is not about adding complexity for its own sake; it is a fundamental principle of database design that ensures data integrity, reduces redundancy, and improves maintainability and performance. Using specific examples from our orders_flat.csv dataset, I will demonstrate why a normalized structure is essential and how the flat table leads to significant practical problems.

Consider the insert anomaly identified earlier: to add a new customer like C009 ("John Doe" from Pune) without any orders, the flat table forces us to create a dummy order record with fabricated product and sales rep details. This violates data integrity by introducing meaningless data, potentially skewing reports and complicating queries. In a normalized schema, we can simply insert into the Customers table independently, maintaining clean, accurate data.

The update anomaly is equally problematic. If Priya Sharma (C002) changes her email, we must update it across multiple rows in the flat table—specifically, rows 2, 5, 7, 20, 29, 37, and 43. This not only increases the risk of errors (e.g., missing a row) but also wastes computational resources and time. In a normalized database, a single update in the Customers table propagates the change correctly, ensuring consistency without manual intervention.

Deletion anomalies further illustrate the risks. Deleting all orders for Kavya Rao (C008) would erase her customer information entirely, even if she remains a valuable contact. This loss of data could harm customer relationship management and lead to incomplete business insights. Normalization prevents this by storing customer data separately, allowing orders to be deleted without affecting entity records.

Beyond anomalies, normalization enhances query efficiency and scalability. In the flat table, retrieving Mumbai customers' total order values requires scanning the entire dataset and aggregating redundant data. Normalized tables with proper indexing allow for faster, more precise queries. As our dataset grows, the flat table's redundancy would consume excessive storage and slow performance, whereas normalized structures scale better.

Moreover, normalization supports better data governance. Changes to product prices or sales rep details are centralized, reducing errors and ensuring auditability. In our dataset, product P001 (Laptop) appears in multiple orders; a price change in the flat table requires updates everywhere, risking inconsistencies.

In conclusion, dismissing normalization as over-engineering ignores its role in building robust, reliable systems. The initial setup effort pays dividends in data quality, performance, and maintainability. For our business, adopting normalization will prevent costly errors and support informed decision-making, far outweighing any perceived simplicity of a flat table. 
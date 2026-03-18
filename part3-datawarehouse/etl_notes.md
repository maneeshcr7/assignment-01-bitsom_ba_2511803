## ETL Decisions

### Decision 1 — Standardize Date Formats
Problem: The raw data contained inconsistent date formats (e.g., "29/08/2023", "12-12-2023", "2023-02-05") which would prevent reliable date-based joins and aggregations.
Resolution: Converted all dates into ISO format (YYYY-MM-DD) and used a consistent integer `date_key` (YYYYMMDD) in the date dimension, ensuring clean joins and enabling accurate time-series analysis.

### Decision 2 — Normalize Category Values
Problem: The `category` field was inconsistently cased (e.g., "electronics", "Electronics", "Grocery", "Groceries"), leading to fragmentation in dimension lookups and inaccurate aggregation by category.
Resolution: Standardized category values into a canonical set (e.g., "Electronics", "Clothing", "Groceries") during ETL so the product dimension stores a consistent category for reporting.

### Decision 3 — Compute and Store Total Transaction Amount
Problem: The raw data did not include a total transaction amount, and existing numeric fields could lead to rounding issues if calculated on the fly in reporting queries.
Resolution: Calculated `total_amount` as `units_sold * unit_price` during ETL and stored it in the fact table, ensuring consistent revenue values across reports and reducing repeated computation at query time.

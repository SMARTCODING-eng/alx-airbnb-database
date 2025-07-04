# Index Performance Analysis

This document outlines the steps to measure query performance before and after adding indexes using SQL's `EXPLAIN` (or `EXPLAIN ANALYZE`/`ANALYSE`) command.

## Prerequisites

1.  Access to your database (e.g., PostgreSQL, MySQL, SQL Server).
2.  A significant amount of sample data in your `users`, `properties`, `bookings`, and `reviews` tables. Performance improvements from indexing are most noticeable on larger datasets (thousands to millions of rows).
3.  The SQL queries you want to optimize (e.g., the complex join, subquery, and aggregation queries from previous tasks).

## Step-by-Step Measurement Process

### Phase 1: Baseline Performance (Before Indexes)

1.  **Ensure no custom indexes exist:** Before starting, verify that the custom indexes defined in `database_index.sql` are NOT present. You might drop them if they exist from a previous run (e.g., `DROP INDEX IF EXISTS idx_users_email;`). Primary keys and foreign keys usually have implicit indexes, which is fine.

2.  **Run `EXPLAIN` (or `EXPLAIN ANALYZE`) for target queries:**
    For each complex query you've written, prefix it with `EXPLAIN` (or `EXPLAIN ANALYZE` in PostgreSQL/MySQL, `SET STATISTICS PROFILE ON` in SQL Server).

    **Example Queries to Test:**

    * **User Login (simple WHERE clause):**
        ```sql
        EXPLAIN ANALYZE
        SELECT user_id, first_name FROM users WHERE email = 'test.user@example.com';
        ```
    * **Properties by City (WHERE clause):**
        ```sql
        EXPLAIN ANALYZE
        SELECT property_id, title, price FROM properties WHERE city = 'Lagos' AND type = 'apartment';
        ```
    * **Bookings by User (JOIN + WHERE):**
        ```sql
        EXPLAIN ANALYZE
        SELECT booking_id, check_in_date, first_name    
        FROM bookings AS b         
        JOIN users AS u ON b.user_id = u.user_id        
        WHERE u.user_id = 'some_user_uuid';
            
    * **Properties with High Average Rating (Subquery - non-correlated):**
        ```sql
        EXPLAIN ANALYZE
        SELECT property_id, price, title
        FROM properties AS p
        WHERE p.property_id IN(SELECT r.property_id FROM reviews AS r GROUP BY r.property_id HAVING AVG(r.rating)> 4.0);
            
        ```
    * **Ranking Properties by Bookings (Window Function):**
        ```sql
        EXPLAIN ANALYZE
        SELECT property_id, property_title, total_bookings, RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
            
            
        FROM (
            SELECT
                property_id, title AS property_title, COUNT(b.booking_id) AS total_bookings
            FROM
                properties AS p
            LEFT JOIN
                bookings AS b ON p.property_id = b.property_id
            GROUP BY
                p.property_id, p.title
        ) AS PropertyBookings
        ORDER BY
            booking_rank ASC;
        ```

3.  **Record the output:**
    Carefully examine the output of `EXPLAIN ANALYZE`. Look for:
    * **Execution Time:** The total time taken for the query (e.g., `Execution Time: X.XX ms`). This is your primary metric.
    * **Cost:** An estimated cost metric provided by the database optimizer.
    * **Scan Types:** Identify if the database is performing "Full Table Scans" (slow) versus "Index Scans" (fast).
    * **Rows Processed:** Number of rows involved in each step.
    * **Buffer/Disk Reads:** How much I/O is involved.

    Save these outputs for comparison.

### Phase 2: Add Indexes

1.  **Execute the `CREATE INDEX` commands:**
    Run the SQL commands from your `database_index.sql` file.

    ```sql
    -- Example for PostgreSQL/MySQL
    CREATE UNIQUE INDEX idx_users_email ON users (email);
    CREATE INDEX idx_properties_owner_id ON properties (owner_id);
    -- ... continue with all other CREATE INDEX commands
    ```
    Confirm that the indexes were created successfully.

### Phase 3: Performance After Indexes

1.  **Run `EXPLAIN` (or `EXPLAIN ANALYZE`) again:**
    Execute the *exact same* set of complex queries from Phase 1, again prefixed with `EXPLAIN ANALYZE`.

    **Example:**
    ```sql
    EXPLAIN ANALYZE
    SELECT user_id, first_name FROM users WHERE email = 'test.user@example.com';
    -- ... repeat for all other test queries
    ```

2.  **Record and Compare the output:**
    Again, carefully examine the output.
    * **Compare Execution Time:** You should typically see a significant reduction in execution time for queries that benefit from the new indexes.
    * **Observe Scan Types:** Look for changes from "Full Table Scan" to "Index Scan" or "Index Only Scan."
    * **Costs:** Database optimizer costs should also decrease.
    * **I/O:** Reduced disk I/O.

## Analysis and Conclusion

Summarize your findings in this `index_performance.md` file:

* For each tested query, present a "Before Indexing" and "After Indexing" summary of the key metrics (Execution Time, Scan Types, etc.).
* Discuss the improvements observed.
* Explain *why* the indexes improved performance for specific queries (e.g., "The `idx_users_email` index allowed the `SELECT users WHERE email = ...` query to go from a full table scan to a fast index lookup, reducing execution time from Xms to Yms").
* Note any queries that did not see significant improvement (some queries, especially those that need to read a large percentage of the table, might not benefit much from simple indexes, or might require different indexing strategies like covering indexes).
* Provide any insights gained regarding indexing strategies.
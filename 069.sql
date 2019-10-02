DROP PROCEDURE IF EXISTS orderAnalytics;
CREATE PROCEDURE orderAnalytics()
BEGIN

    CREATE TABLE IF NOT EXISTS order_analytics REPLACE AS SELECT id, YEAR(order_date) AS year, QUARTER(order_date) AS quarter, type, (quantity * price) AS total_price FROM orders WHERE id; INSERT INTO order_analytics(id, year, quarter, type, total_price) SELECT o.id, YEAR(o.order_date) AS year, QUARTER(o.order_date) AS quarter, o.type, (o.quantity * o.price) AS total_price FROM orders o WHERE o.id NOT IN ( SELECT oa.id FROM order_analytics oa);

    SELECT *
    FROM order_analytics
    ORDER by id;
END;

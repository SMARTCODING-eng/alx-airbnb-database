SELECT property_id, title, price FROM properties as p
SELECT property_id FROM reviews AS r 
WHERE r.property_id = p.property_id 
HAVING AVG(r.rating) > 4.0
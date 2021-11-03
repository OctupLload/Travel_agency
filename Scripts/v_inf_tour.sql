--View based on tables: tours, hotels, tr_operators 
--This view uses in package named PKG_TOURS on line 178

CREATE OR REPLACE VIEW V_INF_TOUR AS 
  	SELECT t.tour_id ,
           t.country AS country,
           h.hotel_name,
           o.operator_name AS tr_operator,
           t.cost AS price
	FROM tours t INNER JOIN hotels h ON t.hotel_id = h.hotel_id
                 INNER JOIN tr_operators o ON t.operator_id = o.operator_id
    ORDER BY t.tour_id;

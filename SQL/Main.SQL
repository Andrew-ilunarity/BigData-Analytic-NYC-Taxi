create materialized view "Taxi".Geo_value_taxi as (
select
	date_trunc('hour', tpep_pickup_datetime) as "Trip time",
	round(avg(tip_amount ), 2) as "AVG tip",
	round(avg(total_amount), 2) as "AVG amount",
	round(avg(extract(epoch from(tpep_dropoff_datetime - tpep_pickup_datetime))/60), 2) as "AVG drive time",
	round(avg(trip_distance), 2) as "AVG Trip distance",
	----
	round(pickup_latitude, 2) as "Pickup latitude rounded",
	round(pickup_longitude, 2) as "Pickup longitude rounded",
	count(*) as "Trips"
from "Taxi".yellowcar
where total_amount > 0
	and tip_amount < total_amount
	and fare_amount > 0
	and passenger_count > 0
	and trip_distance <= 1000
	and pickup_latitude >= 40.0 and pickup_latitude <= 41.0
	and pickup_longitude >= -75 and pickup_longitude <= -73
group by 1, 6, 7
having count(*) > 10);
